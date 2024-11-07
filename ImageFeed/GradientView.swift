//
//  GradientView.swift
//  ImageFeed
//
//  Created by Jojo Smith on 11/7/24.
//

import UIKit

class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupGradient()
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        let black = UIColor.ypBlack.withAlphaComponent(0.2)
        let clear = UIColor.clear
        gradientLayer.colors = [clear.cgColor, black.cgColor]
    }
}
