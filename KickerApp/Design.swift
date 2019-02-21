//
//  Design.swift
//  Reciper
//
//  Created by Phuong Nguyen on 13.11.18.
//  Copyright © 2018 Phuong Nguyen. All rights reserved.
//

import UIKit
@IBDesignable

class Design: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var background: UIColor = CustomColor.orangeLight {
        didSet {
            layer.backgroundColor = background.cgColor
        }
    }

    @IBInspectable var borderColor: UIColor = CustomColor.orangeLight {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

struct CustomFont {
    static let lightWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Light", size: fontsize)!
    }

    static let mediumWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Medium", size: fontsize)!
    }

    static let boldWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Bold", size: fontsize)!
    }

    static let blackWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Black", size: fontsize)!
    }

    static let ralewayBlackWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-Black", size: fontsize)!
    }

    static let ralewayMediumWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-Medium", size: fontsize)!
    }

    static let ralewayBoldWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-Bold", size: fontsize)!
    }

    static let ralewayLightWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-ExtraLight", size: fontsize)!
    }
}

struct CustomColor {
    static let lightYellow = UIColor(red: 0.97, green: 0.91, blue: 0.63, alpha: 1.0)
    static let orangeDark = UIColor(red: 1.00, green: 0.52, blue: 0.36, alpha: 0.5)
    static let orangeLight = UIColor(red: 1.00, green: 0.65, blue: 0.00, alpha: 1.0)
}

struct GradientColor {
    static let orange1 = UIColor(red:1.00, green:0.69, blue:0.74, alpha:1.0)
    static let orange2 = UIColor(red:1.00, green:0.76, blue:0.63, alpha:1.0)
    static let orangeLight1 = UIColor(red:1.00, green:0.76, blue:0.63, alpha:1.0)
    static let orangeLight2 = UIColor(red:0.98, green:0.67, blue:0.49, alpha:1.0)
    static let yellow1 = UIColor(red:0.98, green:0.67, blue:0.49, alpha:1.0)
    static let yellow2 = UIColor(red:0.97, green:0.81, blue:0.41, alpha:1.0)
    static let blue1 = UIColor(red:0.56, green:0.77, blue:0.99, alpha:1.0)
    static let blue2 = UIColor(red:0.88, green:0.76, blue:0.99, alpha:1.0)
    static let mint1 = UIColor(red:0.55, green:0.99, blue:1.00, alpha:1.0)
    static let mint2 = UIColor(red:0.50, green:0.98, blue:0.72, alpha:1.0)
    static let mint3 = UIColor(red:0.03, green:0.68, blue:0.92, alpha:1.0)
    static let mint4 = UIColor(red:0.16, green:0.96, blue:0.60, alpha:1.0)
  //  static let mint2 = UIColor(red:0.27, green:0.91, blue:0.58, alpha:1.0)
}
