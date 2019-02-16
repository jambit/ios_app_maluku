//
//  ViewController.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 15.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, Storyboarded {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var usersTableView: UITableView!
    @IBOutlet var addButton: CustomButton!
    @IBOutlet var textFieldView: UIView!
    @IBOutlet var textFieldViewHeight: NSLayoutConstraint!

    //MARK: Properties
    weak var coordinator: MainCoordinator?
    var users = [UserInfo]()
    var savedUserName = UserDefaults.standard.string(forKey: "savedUserName")

    private var refreshTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserTableView()
        registerCustomCell()
        setupNameTextFieldView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        addButton.isHidden = false
    }

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
        nameTextField.textColor = CustomColors().orangeDark
        nameTextField.font = CustomFont().ralewayLightWithSize(34)
    }

    @objc private func keyboardWasShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let textFieldBottomConstraint = NSLayoutConstraint(item: nameTextField, attribute: .bottom, relatedBy: .equal, toItem: textFieldView, attribute: .bottom, multiplier: 1, constant: 0)
            textFieldBottomConstraint.constant = -keyboardFrame.height
            textFieldViewHeight.constant = nameTextField.frame.height + keyboardFrame.height
            view.layoutIfNeeded()
        }
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

    @objc func updateData() {
        UserService.shared.getUserInfo(completionHandler: { [weak self] user in
            self?.users = user
            DispatchQueue.main.async { [weak self] in
                self?.usersTableView.reloadData()
            }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "customListTableViewCell", for: indexPath) as? CustomListTableViewCell else { return UITableViewCell() }
        let user = users[indexPath.row]
        setupUsernameCell(cell, for: user.name)
        cell.userImage.image = UIImage(named: "user")
        cell.deleteButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        if cell.userName.text == savedUserName {
                displayButtons(accordingTo: UserOption.reserved, for: cell)
        } else {
           // cell.deleteButton.isHidden = true
            displayButtons(accordingTo: UserOption.notReserved, for: cell)
        }
        return cell
    }

    @objc func deleteUser () {
        let savedUser = users.first(where: { $0.name == savedUserName })
        UserService.shared.deleteUSer(user: savedUser)
        addButton.isHidden = false
    }

    private func setupUsernameCell(_ cell: CustomListTableViewCell, for username: String) {
        cell.userName.text = rawUsername(username)
        cell.userName.lineBreakMode = .byCharWrapping
        cell.userName.font = CustomFont().ralewayLightWithSize(25)
        cell.userName.textColor = UIColor.black
    }

    let rawUsername = { (username: String) -> String in
        username.replacingOccurrences(of: "%7B%0A%09%22name%22%3A+%27test%27%2C%0A%7D=", with: "").replacingOccurrences(of: "name=", with: "").replacingOccurrences(of: "&", with: "")
    }

    private func registerCustomCell() {
        let customCell = UINib(nibName: "CustomListTableViewCell", bundle: Bundle.main)
        usersTableView.register(customCell, forCellReuseIdentifier: "customListTableViewCell")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        blurEffectView.removeFromSuperview()
        textFieldView.isHidden = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let userName = nameTextField.text else { return false }
        UserService.shared.addUser(nameOfUser: userName)
        UserDefaults.standard.set(userName, forKey: "savedUserName")
        savedUserName = UserDefaults.standard.string(forKey: "savedUserName")
        blurEffectView.removeFromSuperview()
        textFieldView.isHidden = true
        return true
    }

    let blurEffectView: UIVisualEffectView = {
        let bluredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return bluredView
    }()

    @IBAction func addUser(_ sender: Any) {
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        textFieldView.isHidden = false
        view.bringSubviewToFront(textFieldView)
        nameTextField.becomeFirstResponder()
    }

    enum UserOption {
        case reserved
        case notReserved
    }
    private func displayButtons(accordingTo option: UserOption, for cell: CustomListTableViewCell) {
        switch option {
        case .reserved:
            addButton.isHidden = true
            cell.deleteButton.isHidden = false
        case .notReserved:
           // addButton.isHidden = false
           cell.deleteButton.isHidden = true
        }
    }
}
