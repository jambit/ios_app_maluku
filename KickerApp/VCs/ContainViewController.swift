//
//  ContainViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 25.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class ContainViewController: UIViewController, Storyboarded {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!

    private var sideBarisOpen = false
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItems = [barButtonItem(image: UIImage(named: "iconmenu"), target: self, action: #selector (toggleSideMenu))]
        children.compactMap({ $0 as? CustomSideMenuViewController }).first?.coordinator = coordinator
    }

    @objc func toggleSideMenu() {
        if sideBarisOpen {
            sideBarisOpen = false
            sideMenuLeadingConstraint.constant = -sideMenuView.frame.width

        } else {
            sideBarisOpen = true
            sideMenuLeadingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
     
    }

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

}
