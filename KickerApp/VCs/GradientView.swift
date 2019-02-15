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

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    //common func to init our view
    public func setupView() {
        setGradientBackground(color1:UIColor.white, color2:UIColor.black)
        frame = bounds
    }
}

class GradientView1: GradientView {

    //common func to init our view
    override func setupView() {
        setGradientBackground(color1: UIColor(red:1.00, green:0.69, blue:0.74, alpha:1.0), color2: UIColor(red:1.00, green:0.76, blue:0.63, alpha:1.0))
        frame = bounds
    }
}

class GradientView2: GradientView {

    //common func to init our view
    override func setupView() {
        setGradientBackground(color1: UIColor(red:0.56, green:0.77, blue:0.99, alpha:1.0), color2: UIColor(red:0.88, green:0.76, blue:0.99, alpha:1.0))
        frame = bounds
    }

//      setGradientBackground(color1: UIColor(red:1.00, green:0.76, blue:0.63, alpha:1.0), color2: UIColor(red:0.98, green:0.67, blue:0.49, alpha:1.0))
//      setGradientBackground(color1: UIColor(red:0.56, green:0.77, blue:0.99, alpha:1.0), color2: UIColor(red:0.88, green:0.76, blue:0.99, alpha:1.0))

    }


class GradientView3: GradientView {

//      setGradientBackground(color1: UIColor(red:0.98, green:0.67, blue:0.49, alpha:1.0), color2: UIColor(red:0.97, green:0.81, blue:0.41, alpha:1.0))

    override func setupView() {
        setGradientBackground(color1: UIColor(red:1.00, green:0.69, blue:0.74, alpha:1.0), color2: UIColor(red:1.00, green:0.76, blue:0.63, alpha:1.0))
        frame = bounds
    }
}



extension UIView {
    func setGradientBackground(color1: UIColor, color2: UIColor) {
        let gradientView = UIView(frame: self.frame)
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = gradientView.frame.size
        gradientLayer.colors = [color1.cgColor,color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.addSublayer(gradientLayer)
        self.insertSubview(gradientView, at: 0)

    }
}



