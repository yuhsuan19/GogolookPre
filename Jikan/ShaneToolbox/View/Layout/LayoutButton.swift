//
//  LayoutButton.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class LayoutButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(image: UIImage?, target: Any? = nil, action: Selector? = nil, for event: UIControl.Event = .touchUpInside) {
        self.init(type: .custom)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(image, for: .normal)
        
        if let action = action {
            addTarget(target, action: action, for: event)
        }
    }
    
    convenience init(title: String, target: Any? = nil, action: Selector? = nil, for event: UIControl.Event = .touchUpInside) {
        self.init(type: .system)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        
        if let action = action {
            addTarget(target, action: action, for: event)
        }
    }
}
