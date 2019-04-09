//
//  ContainerViewModel.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 09.03.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

enum sideBarState {
    case open
    case close
}

extension sideBarState {
    func inverted() -> sideBarState {
        switch self {
        case .open:
            return .close
        case .close:
            return .open
        }
    }
}

public class ContainerViewModel {
    
    private func barButtonItem(image: UIImage?, target: Any?, action: Selector) -> UIBarButtonItem {
        guard let image = image else {
            print("Provided image for UIBarButtonItem is nil")
            return UIBarButtonItem(title: nil, style: .plain, target: target, action: action)
        }

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        return UIBarButtonItem(customView: button)
    }

    public func hamBurgerItem(action: Selector, target: Any?) -> UIBarButtonItem {
        return barButtonItem(image: UIImage(named: "iconmenu"), target: target, action: action)
    }
}
