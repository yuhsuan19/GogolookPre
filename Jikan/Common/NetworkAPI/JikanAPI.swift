//
//  JikanAPI.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import Foundation

enum JikanAPI {
    case top(type: String, page: Int?, subtype: String?)
}

extension JikanAPI: NetworkService {
    var baseURL: URL {
        return URL(string: "https://api.jikan.moe/v3/")!
    }
    
    var path: String {
        switch self {
        case .top(let type, let page, let subtype):
            let parameters: [Any?] = [type, page, subtype]
            var path = "top"
            (parameters.compactMap() { $0 }).forEach() {
                path += "/\($0)"
            }
            return path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .top:
            return .get
        }
    }
    
    var httpHeaders: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any?]? {
        return nil
    }
    
    var encoding: Encoding? {
        switch self {
        case .top:
            return .url
        }
    }
    
    var timeout: TimeInterval {
        return 15
    }
    
    var uploadContent: UploadContent? {
        return nil
    }
}

