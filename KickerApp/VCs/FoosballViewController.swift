//
//  KIckerViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 16.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class FoosballViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, Storyboarded {

    // MARK: - Outlets
    @IBOutlet var foosballTitleLabel: UILabel!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var foosballTableCollection: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet var gradientView1: GradientView1!
    @IBOutlet var gradientView2: GradientView2!
    @IBOutlet var gradientView3: GradientView3!

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private var timer: Timer?
    private var indexBeforeDragging = 0
    private let viewModel = FoosballTableViewModel()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foosballTableCollection.dequeueReusableCell(withReuseIdentifier: "FoosballCollectionViewCell", for: indexPath) as! FoosballCollectionViewCell
        let table = viewModel.tables[indexPath.row]
        let tableNumber = indexPath.row + 1
        cell.setupUI(for: table)
        cell.display(viewModel.occupiedTables, at: tableNumber)
        return cell
    }

    //Get the cell index before start swiping
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexBeforeDragging = IndexPath(row: viewModel.indexCell(of: collectionViewFlowLayout), section: 0).row
    }

    //Change background when user swipes to a specific cell
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexPath = IndexPath(row: viewModel.indexCell(of: collectionViewFlowLayout), section: 0)
        foosballTableCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let currentIndex = indexPath.row
        changeBackground(from: indexBeforeDragging, to: currentIndex)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        foosballTitleLabel.setupTitle(font: CustomFont.ralewayBlackWithSize, 33)
        currentTimeLabel.setupTitle(font: CustomFont.gilroyLightWithSize, 23)
        setUpNavigationBarItem()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(reloadView), userInfo: nil, repeats: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(reloadView), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    //Get data from backend and reload the view
    @objc private func reloadView() {
        foosballTableCollection.reloadData()
        currentTimeLabel.text = viewModel.currentTimeText
    }
}

// MARK: - Styling Background
private extension FoosballViewController {

    private func gradientBackground(of cellIndex: Int) -> UIView {
        switch cellIndex {
        case 0:
            return gradientView1
        case 1:
            return gradientView2
        case 2:
            return gradientView3
        default:
            return gradientView1
        }
    }

    private func changeBackground(from lastCell: Int, to toCell: Int) {
        UIView.transition(from: gradientBackground(of: lastCell),
                          to: gradientBackground(of: toCell),
                          duration: 0.5,
                          options: [.transitionCrossDissolve, .showHideTransitionViews],
                          completion: nil)
    }
}
