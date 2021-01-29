//
//  LayoutTool.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation
import UIKit

// MARK: Clean layout
extension UIView {
    
    // MARK: Position
    func addSubView(_ view: UIView, anchorInsets: [EdgeInsets] = []) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        anchorInsets.forEach() {
            switch $0 {
            case .leading:
                view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            case .top:
                view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            case .trailing:
                view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            case .bottom:
                view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            }
        }
    }
    
    func addFilledSubView(_ view: UIView, safeInsets: [EdgeInsets] = []) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: safeInsets.contains(.leading) ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor),
            view.topAnchor.constraint(equalTo: safeInsets.contains(.top) ? safeAreaLayoutGuide.topAnchor : topAnchor),
            view.bottomAnchor.constraint(equalTo: safeInsets.contains(.bottom) ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor),
            view.trailingAnchor.constraint(equalTo: safeInsets.contains(.trailing) ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor)
        ])
    }
    
    func addSafeFilledSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func addCenterSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func addCenterXSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func addCenterYSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func addSameWidthSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addCenterXSubview(view)
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func addSameHeightSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addCenterYSubview(view)
        view.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    enum EdgeInsets {
        case top
        case leading
        case trailing
        case bottom
    }
    
    // MARK: Size
    func squared(size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func rectangled(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

// MARK: Adjust value based on screen size
extension CGFloat {
    func basedOnScreenWidth(_ basedScreenWidth: CGFloat = 360) -> CGFloat {
        guard basedScreenWidth != 0 else {
            fatalError("Cannot adjust CGFloat based on screen width equal to 0")
        }
        return self * UIScreen.main.bounds.width / basedScreenWidth
    }
    
    func basedOnScreenHeight(_ basedScreenHeight: CGFloat = 640) -> CGFloat {
        guard basedScreenHeight != 0 else {
            fatalError("Cannot adjust CGFloat based on screen height equal to 0")
        }
        return self * UIScreen.main.bounds.height / basedScreenHeight
    }
}

extension Double {
    func basedOnScreenWidth(_ basedScreenWidth: CGFloat = 360) -> CGFloat {
        guard basedScreenWidth != 0 else {
            fatalError("Cannot adjust Double based on screen width equal to 0")
        }
        return CGFloat(self) * UIScreen.main.bounds.width / basedScreenWidth
    }
    
    func basedOnScreenHeight(_ basedScreenHeight: CGFloat = 640) -> CGFloat {
        guard basedScreenHeight != 0 else {
            fatalError("Cannot adjust Double based on screen height equal to 0")
        }
        return CGFloat(self) * UIScreen.main.bounds.height / basedScreenHeight
    }
}

extension Float {
    func basedOnScreenWidth(_ basedScreenWidth: CGFloat = 360) -> CGFloat {
        guard basedScreenWidth != 0 else {
            fatalError("Cannot adjust Float based on screen width equal to 0")
        }
        return CGFloat(self) * UIScreen.main.bounds.width / basedScreenWidth
    }
    
    func basedOnScreenHeight(_ basedScreenHeight: CGFloat = 640) -> CGFloat {
        guard basedScreenHeight != 0 else {
            fatalError("Cannot adjust Float based on screen height equal to 0")
        }
        return CGFloat(self) * UIScreen.main.bounds.height / basedScreenHeight
    }
}

extension Int {
    func basedOnScreenWidth(_ basedScreenWidth: CGFloat = 360) -> CGFloat {
        guard basedScreenWidth != 0 else {
            fatalError("Cannot adjust Int based on screen width equal to 0")
        }
        return CGFloat(self) * UIScreen.main.bounds.width / basedScreenWidth
    }
    
    func basedOnScreenHeight(_ basedScreenHeight: CGFloat = 640) -> CGFloat {
        guard basedScreenHeight != 0 else {
            fatalError("Cannot adjust Int based on screen height equal to 0")
        }
        return CGFloat(self) * UIScreen.main.bounds.height / basedScreenHeight
    }
}

