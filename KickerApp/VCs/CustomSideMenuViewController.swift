//
//  CustomSideMenuViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 25.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

struct Option: Equatable {
    var title: String
    var icon: UIImage

    init(title: String, icon: UIImage?) {
        self.title = title
        self.icon = icon ?? UIImage()
    }
}

class CustomSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Storyboarded {
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBAction func closeSideMenu(_ sender: Any) {
                NotificationCenter.default.post(name: NSNotification.Name("toggleSideMenu"), object: nil)
    }
   weak var coordinator: MainCoordinator?
    var containerNavigatonController: ContainerNavigationController?

    private let options : [Option] = {() -> [Option] in
        var options: [Option] = []
        options.append(Option(title: "Kickertische", icon: UIImage(named: "foosball_gray1")))
        options.append(Option(title: "Liste", icon: UIImage(named: "list_gray1")))
        return options
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: "customListTableViewCell", for: indexPath) as? CustomListTableViewCell else { return UITableViewCell() }
        cell.userName.font = CustomFont.ralewayLightWithSize(20)
        cell.userName.lineBreakMode = .byCharWrapping
        cell.userName.textColor = UIColor.gray
        cell.userName?.text = options[indexPath.row].title
        cell.userImage.image = options[indexPath.row].icon
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomListTableViewCell else { return}
        guard let containerNavigatonController = containerNavigatonController else {return}
        if cell.userName.text == options[1].title {
            coordinator?.openListView(from: containerNavigatonController)
            NotificationCenter.default.post(name: NSNotification.Name("toggleSideMenu"), object: nil)
        } else {
            coordinator?.openFoosballView(from: containerNavigatonController)
            NotificationCenter.default.post(name: NSNotification.Name("toggleSideMenu"), object: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    private func registerTableCell () {
        let customCell = UINib(nibName: "CustomListTableViewCell", bundle: Bundle.main)
        sideMenuTableView.register(customCell, forCellReuseIdentifier: "customListTableViewCell")
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0.95
        sideMenuTableView.backgroundColor = .clear
        registerTableCell()
    }


}
