//
//  UIStackViewExtension.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach() {
            addArrangedSubview($0)
        }
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach() {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
