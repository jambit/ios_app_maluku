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

    func openContainerView() {
        let vc = ContainViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func start() {
        let launchScreen = LaunchScreenViewController.instantiate()
        launchScreen.coordinator = self
        navigationController.pushViewController(launchScreen, animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            [weak self] in
            self?.openContainerView()
        })
    }

    func openFoosballView(from containerNavigationController: ContainerNavigationController) {
        let vc = FoosballViewController.instantiate()
        vc.coordinator = self
        containerNavigationController.pushViewController(vc, animated: true)
    }

    func openListView(from containerNavigationController: ContainerNavigationController) {
        let vc = ListViewController.instantiate()
        vc.coordinator = self
        containerNavigationController.pushViewController(vc, animated: true)
    }

    func openStatisticView(from containerNavigationController: ContainerNavigationController) {
        let vc = ListViewController.instantiate()
        vc.coordinator = self
        containerNavigationController.pushViewController(vc, animated: true)
        }
}
