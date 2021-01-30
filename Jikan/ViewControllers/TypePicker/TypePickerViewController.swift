//
//  TypePickerViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import UIKit

class TypePickerViewController: BasedViewController<BasedViewModel> {

    init() {
        super.init(viewModel: BasedViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .tertiarySystemBackground
    }
}
