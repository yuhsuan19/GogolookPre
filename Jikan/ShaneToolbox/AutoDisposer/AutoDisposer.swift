//
//  AutoDisposer.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation

protocol AutoDisposer: NSObject {
    var observedKeyPaths: [String] { set get }
    var keyPathObservingActions: [String: () -> Void] { set get }
}

extension AutoDisposer {
    func addObservedKeyPath(_ keyPath: String, observingAction: (() -> Void)?) {
        addObserver(self, forKeyPath: keyPath, options: [.new], context: nil)
        observedKeyPaths.append(keyPath)
        
        if let action = observingAction {
            keyPathObservingActions = [keyPath: action]
        }
    }
    
    
    // Note: add this function into NSObject's deinit
    func disposed() {
        observedKeyPaths.forEach() {
            removeObserver(self, forKeyPath: $0, context: nil)
        }
    }
}
