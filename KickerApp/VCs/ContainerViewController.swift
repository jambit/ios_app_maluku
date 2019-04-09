//
//  ContainerViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 25.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

public class ContainerViewController: UIViewController, Storyboarded, UIGestureRecognizerDelegate {

    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var sideMenuView: UIView!
    @IBOutlet private weak var sideMenuLeadingConstraint: NSLayoutConstraint!

    // MARK: - Properties
    fileprivate var state: sideBarState = .close
    private let viewModel = ContainerViewModel()
    var containerNavigationController: ContainerNavigationController?
    weak var coordinator: MainCoordinator?

    // MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        passCoordinatorToChildVCs()
        containerView.setUpUI()
        addGestureRecognizer()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: .toogleMenu, object: nil)
        navigationController?.isNavigationBarHidden = true
    }

    // Pass the same coordinator on to side menu so that It can manage other view controllers
    private func passCoordinatorToChildVCs() {
        containerNavigationController = children.compactMap({ $0 as? ContainerNavigationController }).first

        if let sideMenuVC = children.compactMap({ $0 as? CustomSideMenuViewController }).first {
            sideMenuVC.coordinator = coordinator
            sideMenuVC.containerNavigatonController = containerNavigationController
        }
    }
}

// MARK: - Animate Views
public extension ContainerViewController {
    private func changeContainerViewheight(state: sideBarState) {
        switch state {
        case .open:
           containerView.animateTo(frame: CGRect(x: sideMenuView.frame.width + 15, y: (view.frame.height - view.frame.height * 0.9)/2, width: view.frame.width * 0.9, height: view.frame.height * 0.9), withDuration: 0.3)
        case .close:
            containerView.animateTo(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), withDuration: 0.3)
        }
    }

    private func changeMenuBarConstraint(state: sideBarState) {
        switch state {
        case .open:
            sideMenuLeadingConstraint.constant = 0
        case .close:
            sideMenuLeadingConstraint.constant = -sideMenuView.frame.width
            sideMenuView.center.x = -sideMenuView.frame.width / 2
        }
        view.layoutIfNeeded()
    }

    public func closeMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.changeMenuBarConstraint(state: .close)
        })
          changeContainerViewheight(state: .close)
    }

    public func openMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.changeMenuBarConstraint(state: .open)
        })
           changeContainerViewheight(state: .open)
    }

    @objc public func toggleSideMenu() {
        state == .close ? openMenu() : closeMenu()
        state = state.inverted()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        closeMenu()
        state = .close
    }
}

// MARK: - Styling
private extension UIView {
    func setUpUI() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        createShadow(color: CustomColor.cadmiunOrange)
    }
}

// MARK: - GestureRecognizer for sliding menu bar
private extension ContainerViewController {
    func addGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.cancelsTouchesInView = false
        containerView.addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            guard let view = recognizer.view else { return }
            containerView.center.x = containerView.center.x + recognizer.translation(in: view).x
            sideMenuView.center.x = sideMenuView.center.x + recognizer.translation(in: view).x
            recognizer.setTranslation(CGPoint.zero, in: containerView)
            restrictGestureRecognizer()
        case .ended:
            guard let view = recognizer.view else { return }
            view.center.x > containerView.frame.size.width ? toogleMenuBar() : closeMenu()
        default:
            break
        }
    }

    private func restrictGestureRecognizer() {
        let parentViewXValue = view.frame.minX
        let containerViewSize = containerView.frame.size
        let containerViewXValue = containerView.frame.origin.x
        let containerViewYValue = containerView.frame.origin.y

        let sideMenuSize = sideMenuView.frame.size
        let sideMenuViewXValue = sideMenuView.frame.origin.x
        let sideMenuViewYValue = sideMenuView.frame.origin.y

        if containerViewXValue <= parentViewXValue {
            containerView.frame = CGRect(x: parentViewXValue, y: containerViewYValue, width: containerViewSize.width, height: containerViewSize.height)
        }
        if sideMenuViewXValue >= parentViewXValue {
            sideMenuView.frame = CGRect(x: parentViewXValue, y: sideMenuViewYValue, width: sideMenuSize.width, height: sideMenuSize.height)
        }
    }

}

public extension UIViewController {
    @objc public func toogleMenuBar() {
        NotificationCenter.default.post(name: .toogleMenu, object: nil)
    }

    public func setUpNavigationBarItem() {
        navigationItem.leftBarButtonItems = [ContainerViewModel().hamBurgerItem(action: #selector(toogleMenuBar), target: self)]
    }

}

public extension NSNotification.Name {
    public static var toogleMenu: NSNotification.Name {
        return .init("toggleSideMenu")
    }
}
