//
//  LayoutScrollView.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class LayoutScrollView: UIScrollView {
    
    init(isPagingEnabled: Bool = false) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        self.isPagingEnabled = isPagingEnabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
