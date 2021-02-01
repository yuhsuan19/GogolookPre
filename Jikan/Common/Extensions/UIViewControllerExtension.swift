//
//  UIViewControllerExtension.swift
//  Jikan
//
//  Created by CHI on 2021/2/1.
//

import Foundation
import UIKit

extension UIViewController: ErrorPresenter {
    func showError(_ error: Error) {
        if let text = present(error: error) {
            let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
