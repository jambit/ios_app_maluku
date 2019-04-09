//
//  CustomBarItem.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 17.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class CustomBarItem: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var selectedView: UIView!
    var itemType: ItemType?

    func setUp(_ item: Item) {
        icon.image = item.icon
        itemType = item.type
        setUpTitle(for: item)
        setUpSelectedView()
        layer.masksToBounds = true
        backgroundColor = .clear
    }

    private func setUpTitle(for item: Item) {
        itemTitle.font = CustomFont.boldWithSize(20)
        itemTitle.lineBreakMode = .byCharWrapping
        itemTitle.textColor = GradientColor.orange2
        itemTitle?.text = item.title
    }

    private func setUpSelectedView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: selectedView.frame.height))
        view.backgroundColor = GradientColor.sunkiss1
        selectedView.addSubview(view)
        selectedView.backgroundColor = GradientColor.orangeLight1
        selectedView.layer.cornerRadius = frame.height / 2
        selectedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        itemTitle.highlightedTextColor = .white

        selectedBackgroundView = selectedView
    }
    
}
