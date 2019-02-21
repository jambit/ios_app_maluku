//
//  KIckerViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 16.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class FoosballViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate, Storyboarded {
    @IBOutlet var foosballTitleLabel: UILabel!
    @IBOutlet var foosballTableCollection: UICollectionView!
    @IBOutlet var gradientView3: GradientView3!
    @IBOutlet var gradientView1: GradientView1!
    @IBOutlet var gradientView2: GradientView2!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!


    //MARK: Properties
    weak var coordinator: MainCoordinator?
    private var foosballTables = [FoosballTableCodable]()
    private var timer: Timer?
    private var indexOfCellBeforeDragging = 0
    private let tables: [FoosballTable] = { () -> [FoosballTable] in
        let table1 = FoosballTable(name: "Manfred-Harrer-Stadion", backgroundColor: CustomColor.orangeDark, notOccupiedImage: UIImage(named: "kicker_table3_free"), occupiedImage: UIImage(named: "kicker_table3_occupied"))
        let table2 = FoosballTable(name: "Arnim-Kreutzer-Arena", backgroundColor: CustomColor.orangeLight, notOccupiedImage: UIImage(named: "kicker_table2_free"), occupiedImage: UIImage(named: "kicker_table2_occupied"))
        let table3 = FoosballTable(name: "Die Berries", backgroundColor: CustomColor.lightYellow, notOccupiedImage: UIImage(named: "kicker_table1_free"), occupiedImage: UIImage(
            named: "kicker_table1_occupied"))
        return [table1, table2, table3]

    }()

    class Table {
        var occupiedPlaces: [Int] = []
        init() {}
    }

    //Filter occupied tables
    private func occupiedTables() -> [Int] {
        var tables: [Int: Table] = [:]
        for kickerTable in foosballTables {
            var table = tables[kickerTable.table]
            if table == nil {
                table = Table()
                tables[kickerTable.table] = table
            }
            if kickerTable.occupied {
                table?.occupiedPlaces.append(kickerTable.id)
            }
        }
        return tables.filter({ $0.value.occupiedPlaces.count > 1 }).map({ $0.key })
    }

    //Reload view with new data
    @objc private func updateData() {
        FoosballService.shared.getKickerInfo(completionHandler: { [weak self] foosballTables in
            self?.foosballTables = foosballTables })
        foosballTableCollection.reloadData()
        currentTimeLabel.text = "Aktualisiert um: \(currentTime())"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foosballTableCollection.dequeueReusableCell(withReuseIdentifier: "kickerCollectionCell", for: indexPath) as! FoosballCollectionViewCell
        FoosballService.shared.getKickerInfo(completionHandler: { [weak self] kickerTische in
            self?.foosballTables = kickerTische })
        let tableName = tables[indexPath.row].name
        setupUI(of: cell, for: tableName)
        cell.backgroundColor = tables[indexPath.row].backgroundColor
        cell.notOccupiedImage.image = tables[indexPath.row].notOccupiedImage
        cell.occupiedImage.image = tables[indexPath.row].occupiedImage
        cell.occupiedImage.isHidden = true
        let tableNumber = indexPath.row + 1
        displayOccupiedTables(for: cell, at: tableNumber)
        return cell
    }

    private func displayOccupiedTables(for cell: FoosballCollectionViewCell, at tableCell: Int){
        for table in occupiedTables() {
            if table == tableCell {
                cell.occupiedImage.isHidden = false
            }
        }
    }

    private func setupUI(of cell: FoosballCollectionViewCell, for tableName: String) {
        cell.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        setUpCellLabel(of: cell, for: tableName)
        createShadow(for: cell)
    }

    //get the current cell index
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        let proportionalOffset = collectionViewFlowLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = collectionView(foosballTableCollection, numberOfItemsInSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }

    //Change background screen colors when user swipe to a specific cell
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        let dataSourceCount = collectionView(foosballTableCollection, numberOfItemsInSection: 0)
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        if didUseSwipeToSkipCell {

            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)

        } else {
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            guard let foosballCollectionView = collectionViewFlowLayout.collectionView else {return}
            foosballCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      //      let currentCell = foosballCollectionView.cellForItem(at: indexPath)
            let tableCell = indexPath.row + 1
            switch tableCell {
            case 1:
            UIView.transition(from: self.gradientView2, to: self.gradientView1, duration: 0.5, options: [.transitionCrossDissolve, .showHideTransitionViews], completion: nil)
            case 2:
            UIView.transition(from: self.gradientView1, to: self.gradientView2, duration: 0.5, options: [.transitionCrossDissolve, .showHideTransitionViews], completion: nil)
            case 3:
            UIView.transition(from: self.gradientView2, to: self.gradientView3, duration: 0.5, options: [.transitionCrossDissolve, .showHideTransitionViews], completion: nil)
            default:
                break
            }

        }
    }


    private func createShadow(for cell: FoosballCollectionViewCell) {
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 3
        cell.layer.masksToBounds = false
    }

    private func setUpCellLabel(of cell: FoosballCollectionViewCell, for tableName: String) {
        cell.nameOfTable.text = tableName.uppercased()
        cell.nameOfTable.font = CustomFont.ralewayBlackWithSize(20)
        cell.nameOfTable.textColor = UIColor.white
    }

    private func setupTitle(of label: UILabel) {
        label.font = CustomFont.ralewayBlackWithSize(35)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
    }

    private func currentTime() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: now)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle(of: foosballTitleLabel)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
        currentTimeLabel.font = CustomFont.ralewayLightWithSize(20)
        currentTimeLabel.textColor = .white
        gradientView1.frame = view.bounds
        gradientView2.frame = view.bounds
        gradientView3.frame = view.bounds
        view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foosballTableCollection.reloadData()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}
