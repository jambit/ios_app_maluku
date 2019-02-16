//
//  LaunchScreenViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 24.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

public class LaunchScreenViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.setGradientBackground(color1: UIColor(red:1.00, green:0.69, blue:0.74, alpha:1.0), color2: UIColor(red:1.00, green:0.76, blue:0.63, alpha:1.0))
        view.frame = view.bounds
    }

}

