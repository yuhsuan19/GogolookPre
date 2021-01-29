//
//  NetworkServiceProvider.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation
import Alamofire

enum NetworkResult<Value> {
    case success(Value)
    case failure(Error)
}

struct NetWorkResponse {
    var statusCode: Int {
        return response.statusCode
    }
    var data: Data
    var request: URLRequest
    var response: HTTPURLResponse
}

class NetworkServiceProvider {
    static var shared = NetworkServiceProvider()
    
    typealias ProviderCompletion = (NetworkResult<NetWorkResponse>) -> Void
    
    func request(for service: NetworkService, completion: @escaping ProviderCompletion) {
        let request = service.request
        Alamofire.request(request).responseData() { (dataResponse) in
            guard let response = dataResponse.response else {
                // to do: error handle
                return
            }
            
            switch dataResponse.result {
            case .success(let data):
                let response = NetWorkResponse(data: data, request: request, response: response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelableRequest(for service: NetworkService, completion: @escaping ProviderCompletion) -> DataRequest {
        let request = service.request
        let dataRequest = Alamofire.request(request).responseData() { (dataResponse) in
            guard let response = dataResponse.response else {
                if ((dataResponse.result.error) as? URLError)?.errorCode == -999 {
                    return // request is canceled
                } else {
                    // to do: error handle
                    return
                }
            }
            
            switch dataResponse.result {
            case .success(let data):
                let response = NetWorkResponse(data: data, request: request, response: response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return dataRequest
    }
    
    func upload(for service: NetworkService, progressHandler: @escaping((Double) -> Void) = {_ in }, completion: @escaping ProviderCompletion) {
        guard let content = service.uploadContent else {
            // to do: error handle
            return
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(content.data, withName: content.key, fileName: content.filename, mimeType: content.mimeType)
            for (key, value) in service.parameters ?? [:] {
                if let value = value, let data = "\(value)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: service.request.url!, headers: service.request.allHTTPHeaderFields) { (result) in
            switch result {
            case .success(let uploadRequest, _, _):
                uploadRequest.uploadProgress { (progress) in
                    progressHandler(progress.fractionCompleted)
                }
                
                uploadRequest.responseData(completionHandler: { (dataResponse) in
                    guard let response = dataResponse.response else {
                        // to do: error handle
                        return
                    }
                    switch dataResponse.result {
                    case .success(let data):
                        let response = NetWorkResponse(data: data, request: service.request, response: response)
                            completion(.success(response))
                        case .failure(let error):
                            completion(.failure(error))
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
