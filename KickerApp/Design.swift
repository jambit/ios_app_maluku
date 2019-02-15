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

    @IBInspectable var background: UIColor = CustomColors().orangeLight {
        didSet {
            layer.backgroundColor = background.cgColor
        }
    }

    @IBInspectable var borderColor: UIColor = CustomColors().orangeLight {
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
    var lightWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Light", size: fontsize)!
    }

    var mediumWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Medium", size: fontsize)!
    }

    var boldWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Bold", size: fontsize)!
    }

    var blackWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Montserrat-Black", size: fontsize)!
    }

    var ralewayBlackWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-Black", size: fontsize)!
    }

    var ralewayMediumWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-Medium", size: fontsize)!
    }

    var ralewayBoldWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-Bold", size: fontsize)!
    }

    var ralewayLightWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Raleway-ExtraLight", size: fontsize)!
    }
}

struct CustomColors {
    var lightYellow = UIColor(red: 0.97, green: 0.91, blue: 0.63, alpha: 1.0)
    var orangeDark = UIColor(red: 1.00, green: 0.52, blue: 0.36, alpha: 0.5)
    var orangeLight = UIColor(red: 1.00, green: 0.65, blue: 0.00, alpha: 1.0)
}
