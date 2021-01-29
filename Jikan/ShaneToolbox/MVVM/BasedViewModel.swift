//
//  BasedViewModel.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation

class BasedViewModel: NSObject {
    lazy var networkServiceProvider = NetworkServiceProvider.shared
    
    
    // MARK: Loading
    var isLoading: Bool = false {
        didSet {
            onLoading?()
        }
    }
    
    var onLoading: (() -> Void)?
    
}
