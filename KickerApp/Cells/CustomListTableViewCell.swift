//
//  CustomListTableViewCell.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 17.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class CustomListTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var deleteButton: CustomButton!

    private var viewModel = ListViewModel()

    func setup(username: String) {
        setUpNameLabel(username)
        setUpImage()
        setUpButton()
    }

    private func setUpNameLabel(_ username: String) {
        userName.text = username
        userName.lineBreakMode = .byCharWrapping
    //    userName.font = CustomFont.ralewayLightWithSize(25)
        userName.font = CustomFont.gilroyLightWithSize(23)
        userName.textColor = UIColor.black
    }

    private func setUpImage() {
        userImage.image = UIImage(named: "user")
    }

    private func setUpButton() {
        deleteButton.tintColor = UIColor.red
    }
}
