//
//  GradientView1.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 27.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // common func to init our view
    public func setupView() {
        setGradientBackground(color1: UIColor.white, color2: UIColor.black)
        frame = bounds
    }
}

class GradientView1: GradientView {
    override func setupView() {
        setGradientBackground(color1: GradientColor.orangeLight1, color2: GradientColor.orangeLight2)
        frame = bounds
    }
}

class GradientView2: GradientView {
    override func setupView() {
        //yellow
        setGradientBackground(color1: GradientColor.sunkiss1, color2: GradientColor.sunkiss2)
        frame = bounds
    }
}

class GradientView3: GradientView {
    override func setupView() {
        setGradientBackground(color1: GradientColor.orange1, color2: GradientColor.orange2)
        frame = bounds
    }
}

extension UIView {
    func setGradientBackground(color1: UIColor, color2: UIColor) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
