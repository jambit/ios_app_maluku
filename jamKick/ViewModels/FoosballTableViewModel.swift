//
//  FoosballTableViewModel.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 23.02.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

struct FoosballTable {
    var name: String
    var backgroundColor: UIColor
    var notOccupiedImage: UIImage?
    var occupiedImage: UIImage?

    init(name: String, backgroundColor: UIColor, notOccupiedImage: UIImage?, occupiedImage: UIImage?) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.notOccupiedImage = notOccupiedImage
        self.occupiedImage = occupiedImage
    }
}

public class FoosballTableViewModel {
    var foosballTables: [FoosballTableCodable]?

    public var occupiedTables: [Int] {
        FoosballService.shared.getKickerInfo(completionHandler: { [weak self] foosballTables in
            self?.foosballTables = foosballTables })
        guard let foosballTables = foosballTables else { return [] }
        return FoosballService.shared.occupiedTables(in: foosballTables)
    }

    var tables: [FoosballTable] {
        let table1 = FoosballTable(name: "Manfred-Harrer-Stadion", backgroundColor: CustomColor.cantaloupe, notOccupiedImage: UIImage(named: "table1_free"), occupiedImage: UIImage(named: "table1_occupied"))
        let table2 = FoosballTable(name: "Arnim-Kreutzer-Arena", backgroundColor: CustomColor.lightOrange, notOccupiedImage: UIImage(named: "table2_free"), occupiedImage: UIImage(named: "table2_occupied"))
        let table3 = FoosballTable(name: "Die Berries", backgroundColor: CustomColor.cadmiunOrange, notOccupiedImage: UIImage(named: "table3_free"), occupiedImage: UIImage(
            named: "table3_occupied"))
        return [table1, table2, table3]
    }

    var currentTimeText: String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: now)
        return "Aktualisiert um \(currentTime)"
    }

    // Get the safe cell index
    func indexCell(of collectionViewFlowLayout: UICollectionViewFlowLayout) -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        let proportionalOffset = collectionViewFlowLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = tables.count
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
}
