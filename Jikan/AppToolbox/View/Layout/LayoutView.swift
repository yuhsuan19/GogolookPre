//
//  LayoutView.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class LayoutView: UIView {
    init(backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
