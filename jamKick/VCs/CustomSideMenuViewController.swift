//
//  CustomSideMenuViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 25.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class CustomSideMenuViewController: UIViewController, Storyboarded {

    // MARK: - Outlets
    @IBOutlet private weak var sideMenuTableView: UITableView!

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    var containerNavigatonController: ContainerNavigationController?
    private let viewModel = CustomBarItemViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        setUpTableView()
        view.backgroundColor = .clear
    }
}

// MARK: - Table View
extension CustomSideMenuViewController: UITableViewDelegate, UITableViewDataSource {

    private func setUpTableView() {
        sideMenuTableView.backgroundColor = .clear
        sideMenuTableView.isScrollEnabled = false
    }

    private func registerTableCell () {
        let customCell = UINib(nibName: viewModel.cellIdentifier, bundle: Bundle.main)
        sideMenuTableView.register(customCell, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as? CustomBarItem else { return UITableViewCell() }
        let item = viewModel.items[indexPath.row]
        cell.setUp(item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomBarItem else { return }
        guard let cellType = cell.itemType else { return }
        openView(itemType: cellType)
        toogleMenuBar()

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    private func openView(itemType: ItemType) {
        guard let containerNavigatonController = containerNavigatonController else { return }
        switch itemType {
        case .foosball:
            coordinator?.openFoosballView(from: containerNavigatonController)
        case .list:
            coordinator?.openListView(from: containerNavigatonController)
        }
    }
}
