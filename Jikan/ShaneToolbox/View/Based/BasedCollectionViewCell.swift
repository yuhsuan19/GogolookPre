//
//  BasedCollectionViewCell.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class BasedCollectionViewCell: UICollectionViewCell, AutoDisposer {
    
    // MARK: Object life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAndLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpAndLayoutViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
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
