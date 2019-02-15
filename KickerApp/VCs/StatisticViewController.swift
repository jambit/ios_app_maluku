//
//  TestViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 16.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var kickerInfoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
