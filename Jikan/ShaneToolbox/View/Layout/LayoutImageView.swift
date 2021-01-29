//
//  LayoutImageView.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class LayoutImageView: UIImageView {
    init(image: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFill) {
        super.init(image: image)
        translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        self.contentMode = contentMode
        clipsToBounds = true
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
