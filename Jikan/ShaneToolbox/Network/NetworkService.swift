//
//  NetworkService.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation
import SwiftyJSON

enum Encoding {
    case url
    case formURLEncoded
    case json
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct UploadContent {
    var key: String
    var data: Data
    var mimeType: String
    var filename: String
}

protocol NetworkService {
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var httpHeaders: [String: String]? { get }
    
    var parameters: [String: Any?]? { get }
    
    var encoding: Encoding? { get }
    
    var timeout: TimeInterval { get }
    
    var uploadContent: UploadContent? { get }
}

extension NetworkService {
    var request: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.path = path
        
        if encoding == .url, let parameters = parameters {
            if urlComponents.queryItems == nil {
                urlComponents.queryItems = []
            }
            
            for parameter in parameters {
                if let value = parameter.value {
                    let item = URLQueryItem(name: parameter.key, value: String(describing: value))
                    urlComponents.queryItems?.append(item)
                } else {
                    let item = URLQueryItem(name: parameter.key, value: nil)
                    urlComponents.queryItems?.append(item)
                }
            }
        }
        
        let url = urlComponents.url(relativeTo: baseURL) ?? baseURL
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = httpHeaders
        
        if let parameters = parameters {
            switch encoding {
            case .formURLEncoded:
                let parameterString = parameters.map({ (key, value) -> String in
                    let value = value ?? ""
                    let valueString = "\(value)".addingPercentEncoding(withAllowedCharacters: []) ?? ""
                    return key + "=" + valueString
                }).joined(separator: "&")
                
                request.httpBody = parameterString.data(using: .utf8)
            case .json:
                if let data = try? JSON(parameters).rawData() {
                    request.httpBody = data
                }
                request.allHTTPHeaderFields?["Content-Type"] = "application/json"
            default:
                break
            }
        }
        
        return request
    }
}
