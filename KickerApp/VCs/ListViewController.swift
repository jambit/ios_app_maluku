//
//  ListViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 15.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, Storyboarded {
    // MARK: - Outlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var usersTableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var textFieldView: UIView!
    @IBOutlet private weak var textFieldViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var returnButton: UIButton!

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private var viewModel = ListViewModel()
    private var refreshTimer: Timer?
    private var savedUser: [User] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCustomCell()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    @IBAction private func addUser(_ sender: Any) {
        showTextView()
        nameTextField.becomeFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        hideTextView()
    }

    @objc private func updateData() {
        view.reloadInputViews()
        usersTableView.reloadData()
        checkUserStatus()
    }

    private func checkUserStatus() {
        savedUser = viewModel.users.filter({$0.name == viewModel.savedUser})
        if savedUser.count == 0 {
            addButton.isHidden = false
        }
    }

    @objc private func deleteUser() {
        UserManager.shared.deleteUser()
        addButton.isHidden = false
    }

    private func hideTextView() {
        blurEffectView.removeFromSuperview()
        view.endEditing(true)
        textFieldView.isHidden = true
    }

    private func showTextView() {
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        textFieldView.isHidden = false

        view.bringSubviewToFront(textFieldView)
    }

    @objc private func progressUserSettings() {
        UserManager.shared.saveUserSettings(nameTextField.text)
        hideTextView()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        progressUserSettings()
        return true
    }

    private let blurEffectView: UIVisualEffectView = {
        let bluredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return bluredView
    }()

    private func displayButtons(for user: CustomListTableViewCell) {
       viewModel.savedUser == user.userName.text ? showDeleteButton(user) : hideDeleteButton(user)
  }

    @objc private func keyboardWasShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

            let textFieldBottomConstraint = NSLayoutConstraint(item: returnButton, attribute: .bottom, relatedBy: .equal, toItem: textFieldView, attribute: .bottom, multiplier: 1, constant: 0)
            textFieldBottomConstraint.constant = -keyboardFrame.height
            textFieldViewHeight.constant = nameTextField.frame.height + keyboardFrame.height + returnButton.frame.height + 10 - view.safeAreaInsets.bottom
            view.layoutIfNeeded()
        }
    }
}

// MARK: Table View
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    private func registerCustomCell() {
        let customCell = UINib(nibName: viewModel.cellID, bundle: Bundle.main)
        usersTableView.register(customCell, forCellReuseIdentifier: viewModel.cellID)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: viewModel.cellID, for: indexPath) as? CustomListTableViewCell else { return UITableViewCell() }
        let user = viewModel.users[indexPath.row]
        cell.setup(username: user.name)
        cell.deleteButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        displayButtons(for: cell)
        return cell
    }
}

// MARK: Styling
extension ListViewController: UITextFieldDelegate {
    private func setupUserTableView() {
        usersTableView.rowHeight = UITableView.automaticDimension
        usersTableView.estimatedRowHeight = 100
        usersTableView.layer.cornerRadius = 20
    }

    private func setupNameTextFieldView() {
        textFieldView.layer.cornerRadius = 27
        textFieldView.layer.masksToBounds = true
        textFieldView.isHidden = true
        nameTextField.delegate = self
        nameTextField.layer.borderColor = UIColor.clear.cgColor
        nameTextField.tintColor = CustomColor.cadmiunOrange
        nameTextField.textColor = CustomColor.orangeDark
        nameTextField.font = CustomFont.ralewayLightWithSize(34)
    }

    private func setUpButton() {
        addButton.layer.cornerRadius = 8
        addButton.layer.masksToBounds = true
        addButton.setGradientBackground(color1: GradientColor.sunkiss1, color2: GradientColor.sunkiss2)
        addButton.alpha = 0.7
        addButton.setTitle(viewModel.addButtonTitle, for: .normal)
        addButton.titleLabel?.font = CustomFont.gilroyLightWithSize(25)

        addButton.isHidden = false
    }

    private func setUpReturnButton() {
        returnButton.setTitle(viewModel.returnButtonTitle, for: .normal)
        returnButton.titleLabel?.font = CustomFont.gilroyLightWithSize(25)
        returnButton.addTarget(self, action: #selector(progressUserSettings), for: .touchUpInside)
        returnButton.layer.masksToBounds = true
        returnButton.backgroundColor = CustomColor.cadmiunOrange
        returnButton.setGradientBackground(color1: GradientColor.sunkiss1, color2: GradientColor.sunkiss2)
    }

    private func setUpUI() {
        setupUserTableView()
        setupNameTextFieldView()
        setUpButton()
        setUpReturnButton()
        setUpNavigationBarItem()
        view.backgroundColor = .white
        view.setGradientBackground(color1: GradientColor.orangeLight1, color2: GradientColor.orangeLight2)
    }

    private func showDeleteButton(_ cell: CustomListTableViewCell) {
        addButton.isHidden = true
        cell.deleteButton.isHidden = false
    }

    private func hideDeleteButton(_ cell: CustomListTableViewCell) {
        cell.deleteButton.isHidden = true
    }
}

