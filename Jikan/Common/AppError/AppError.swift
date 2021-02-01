//
//  AppError.swift
//  Jikan
//
//  Created by CHI on 2021/2/1.
//

import Foundation
enum AppError: Int, Error {
    case networkFailed = 0
    case invalidURL = 1
    
    var localizedDescription: String {
        switch self {
        case .networkFailed:
            return "Network connection fail, retry later."
        case .invalidURL:
            return "Fail to open url."
        }
    }
}


protocol ErrorPresenter {
}

extension ErrorPresenter {
    func present(error: Error?) -> String? {
        guard let error = error else {
            return nil
        }
        
        if let error = error as? AppError {
            return error.localizedDescription
        } else {
            return error.localizedDescription
        }
    }
}
