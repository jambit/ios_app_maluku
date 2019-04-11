//
//  CustomBarItemViewModel.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 09.03.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

struct Item: Equatable {
    var title: String
    var icon: UIImage?
    var type: ItemType

    init(title: String, icon: UIImage?, type: ItemType) {
        self.title = title
        self.icon = icon
        self.type = type
    }
}

enum ItemType: String {
    case foosball = "Kickertische"
    case list = "Liste"
}

extension ItemType {
    private func imageForItem() -> UIImage? {
        switch self {
        case .foosball:
          //  return UIImage(named: "foosball_gray1")
            return UIImage()
        case .list:
          //  return UIImage(named: "list_gray1")
            return UIImage()
        }
    }

    func instantiate() -> Item {
        return Item(title: self.rawValue, icon: imageForItem(), type: self)
    }
}

public class CustomBarItemViewModel {

    private weak var coordinator: MainCoordinator?
    var items: [Item] {
        return [ItemType.foosball.instantiate(), ItemType.list.instantiate()]
    }

    var cellIdentifier: String {
        return "CustomBarItem"
    }

}
