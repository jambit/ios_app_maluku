//
//  KickerCollectionViewCell.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 16.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class FoosballCollectionViewCell: UICollectionViewCell {
    @IBOutlet var notOccupiedImage: UIImageView!
    @IBOutlet var occupiedImage: UIImageView!
    @IBOutlet var nameOfTable: UILabel!

    func setupUI(for table: FoosballTable) {
        layer.cornerRadius = 30
        layer.masksToBounds = true
        setUpCellLabel(for: table.name)
        displayImage(for: table)
        createShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
    }

    func setUpCellLabel(for tableName: String) {
        nameOfTable.text = tableName.uppercased()
        nameOfTable.font = CustomFont.ralewayBlackWithSize(20)
        nameOfTable.textColor = UIColor.white
    }

    func displayImage(for table: FoosballTable) {
        backgroundColor = table.backgroundColor
        notOccupiedImage.image = table.notOccupiedImage
        occupiedImage.image = table.occupiedImage
        occupiedImage.isHidden = true
    }

    func display(_ occupiedTables: [Int], at tableCell: Int){
        for table in occupiedTables {
            if table == tableCell {
                occupiedImage.isHidden = false
            }
        }
    }
}
