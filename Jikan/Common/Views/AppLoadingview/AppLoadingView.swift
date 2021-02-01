//
//  AppLoadingView.swift
//  Jikan
//
//  Created by CHI on 2021/2/1.
//

import UIKit
import Lottie

class AppLoadingView: BasedView {
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "loading")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        return animationView
    }()
    
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
        
        backgroundColor = UIColor.systemBackground.withAlphaComponent(0.3)
        addCenterSubview(animationView)
        animationView.squared(size: 100.basedOnScreenWidth())
    }
    
    func show(with title: String? = nil, on view: UIView) {
        animationView.play()
        view.addFilledSubView(self)
    }
    
    func hide() {
        removeFromSuperview()
    }
}
