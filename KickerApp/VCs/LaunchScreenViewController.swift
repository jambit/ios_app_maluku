//
//  LaunchScreenViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 24.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

public class LaunchScreenViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }

    @objc func splashTimeOut(sender : Timer){
        performSegue(withIdentifier: "tabBarView", sender: self)
    }
}

