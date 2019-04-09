//
//  Design.swift
//  Reciper
//
//  Created by Phuong Nguyen on 13.11.18.
//  Copyright © 2018 Phuong Nguyen. All rights reserved.
//

import UIKit
@IBDesignable

class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var background: UIColor = CustomColor.lightOrange {
        didSet {
            layer.backgroundColor = background.cgColor
        }
    }

    @IBInspectable var borderColor: UIColor = CustomColor.lightOrange {
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
    static let gilroyLightWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Gilroy-Light", size: fontsize)!
    }
    static let gilroyBoldWithSize = { (fontsize: CGFloat) -> UIFont in
        UIFont(name: "Gilroy-ExtraBold", size: fontsize)!
    }
}

struct CustomColor {
    static let lightOrange = UIColor(red: 0.99, green: 0.56, blue: 0.32, alpha: 0.5)
    static let lightYellow = UIColor(red: 1.00, green: 0.74, blue: 0.44, alpha: 0.5)
    static let orangeDark = UIColor(red: 1.00, green: 0.52, blue: 0.36, alpha: 0.4)
    static let cadmiunOrange = UIColor(red: 0.98, green: 0.58, blue: 0.44, alpha: 0.6)
    static let cantaloupe = UIColor(red: 1.00, green: 0.63, blue: 0.47, alpha: 0.6)
    static let peach = UIColor(red: 1.00, green: 0.71, blue: 0.61, alpha: 0.4)
}

struct GradientColor {
    static let orange1 = UIColor(red: 1.00, green: 0.69, blue: 0.74, alpha: 1.0)
    static let orange2 = UIColor(red: 1.00, green: 0.76, blue: 0.63, alpha: 1.0)
    static let orangeLight1 = UIColor(red: 1.00, green: 0.76, blue: 0.63, alpha: 0.8)
    static let orangeLight2 = UIColor(red: 0.98, green: 0.67, blue: 0.49, alpha: 1.0)
    static let yellow1 = UIColor(red: 0.98, green: 0.67, blue: 0.49, alpha: 1.0)
    static let yellow2 = UIColor(red: 0.97, green: 0.81, blue: 0.41, alpha: 1.0)
    static let sunkiss2 = UIColor(red: 1.00, green: 0.56, blue: 0.41, alpha: 0.9)
    static let sunkiss1 = UIColor(red: 0.95, green: 0.63, blue: 0.51, alpha: 0.8)
}

extension UILabel {
    func setupTitle(font customFont: (CGFloat) -> UIFont, _ size: CGFloat) {
        font = customFont(size)
        textColor = .white
        numberOfLines = 0
        lineBreakMode = .byCharWrapping
    }
}
extension UIView {
    func createShadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: -2, height: 10)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 9
        layer.masksToBounds = false
    }

    func animateTo(frame: CGRect, withDuration duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        guard let _ = superview else {return}

        let yScale = frame.size.height / self.frame.size.height
        let xScale = yScale
        let x = frame.origin.x + (self.frame.width * xScale) * self.layer.anchorPoint.x
        let y = frame.origin.y + (self.frame.height * yScale) * self.layer.anchorPoint.y

        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.layer.position = CGPoint(x: x, y: y)
            self.transform = self.transform.scaledBy(x: xScale, y: yScale)
        }, completion: completion)
    }

}
