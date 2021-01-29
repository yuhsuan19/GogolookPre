//
//  BasedView.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import UIKit

class BasedView: UIView, AutoDisposer {
    
    // MARK: Object life cycle
    init() {
        super.init(frame: .zero)
        setUpAndLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposed()
    }
    
    func setUpAndLayoutViews() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Auto disposer
    var observedKeyPaths: [String] = []
    
    var keyPathObservingActions: [String : () -> Void] = [:]
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
            return
        }
        
        if let action = keyPathObservingActions[keyPath] {
            action()
        }
    }
}
