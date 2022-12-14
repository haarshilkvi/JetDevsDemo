//
//  ImShSwiftLoader.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/6/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class ImShSwiftLoader: NSObject {
    
    // MARK: - PRIVATE
    private var window: UIWindow!
    private var isDisplayed: Bool = false
    
    private let bgOverlay: UIView!
    private let loaderView: UIView!
    private let textLabel: UILabel!
    
    static let shared = ImShSwiftLoader()
    
    private override init() {
        window = UIApplication.shared.keyWindow
        
        let loader = UIActivityIndicatorView.init(style: .large)
        loader.tintColor = UIColor.white
        loader.startAnimating()
        
        textLabel = UILabel()
        textLabel.textColor = UIColor.darkText
    //    textLabel.font = UIFont.worksans(size: 16, weight: .Medium)
        
        let stackView = UIStackView(arrangedSubviews: [loader, textLabel])
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 0.0 // 12.0
        
        // Create container view
        loaderView = UIView()
        loaderView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loaderView.layer.cornerRadius = 6
        loaderView.layer.masksToBounds = true
        loaderView.addSubview(stackView)
        
        // Create overlay view
        bgOverlay = UIView()
        bgOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgOverlay.addSubview(loaderView)
        
        loaderView.snp.makeConstraints { (overlay) in
            overlay.width.height.greaterThanOrEqualTo(70)
            overlay.center.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (sv) in
            sv.centerY.equalToSuperview()
            sv.leading.equalToSuperview().offset(25)
            sv.trailing.equalToSuperview().offset(-25)
        }
        
        window.addSubview(bgOverlay)
        
        // Hide the container by default (preparing for animation)
        bgOverlay.alpha = 0
        loaderView.alpha = 0
        loaderView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
    }
    
    private func setText(text: String?) {
        self.textLabel.text = text
        self.textLabel.isHidden = (text == nil)
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [.curveEaseOut], animations: {
            self.loaderView?.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            self.loaderView?.alpha = 0
            self.bgOverlay?.alpha = 0
        }) { (_) in
            self.bgOverlay?.removeFromSuperview()
            self.isDisplayed = false
            self.window.windowLevel = .normal
        }
    }
    
    func show(_ message: String? = nil) {
        if isDisplayed {
            self.setText(text: "")
            return
        }
        
//        self.setText(text: message)
        self.setText(text: "")

        
        // Add bg overlay
        window.addSubview(bgOverlay)
        window.windowLevel = .normal
        bgOverlay.snp.makeConstraints { (container) in
            container.edges.equalToSuperview()
        }
        
        self.isDisplayed = true
        // Animate appear
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [.curveEaseIn], animations: {
            self.loaderView?.transform = CGAffineTransform.identity
            self.loaderView?.alpha = 1
            self.bgOverlay?.alpha = 1
        })
    }
}
