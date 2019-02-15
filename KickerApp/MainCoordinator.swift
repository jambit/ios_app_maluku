//
//  MainCoordinator.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 14.02.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

public class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ContainViewController.instantiate()
        vc.coordinator = self
    //    instantiateSideMenu()
        navigationController.pushViewController(vc, animated: false)
    }

    func openFoosballView() {
        let vc = FoosballViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func openListView() {
        let vc = ListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func instantiateSideMenu() {
        let vc = CustomSideMenuViewController.instantiate()
        vc.coordinator = self
    }
}
