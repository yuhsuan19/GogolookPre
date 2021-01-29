//
//  BasedViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import UIKit

class BasedViewController<ViewModel: BasedViewModel>: UIViewController, AutoDisposer {
    let viewModel: ViewModel
    
    // MARK: Object life cycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposed()
    }
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAndLayoutViews()
    }
    
    func setUpAndLayoutViews() {
    }
    
    func bindViewModel() {
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
