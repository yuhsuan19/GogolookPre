//
//  BasedTableViewCell.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class BasedTableViewCell: UITableViewCell, AutoDisposer {
    
    // MARK: Object life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.backgroundColor = .clear
        selectionStyle = .none
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
