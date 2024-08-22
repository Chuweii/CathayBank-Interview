//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    private var notifications: [NotificationModel]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(notifications: [NotificationModel]) {
        self.notifications = notifications
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - UI Component
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupViews() {
        title = "Notification"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.back))
        navigationController?.navigationBar.tintColor = .black

        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setConstraint() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        let useCells = [NotificationTableViewCell.self]
        useCells.forEach {
            tableView.register($0.self, forCellReuseIdentifier: "NotificationTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraint()
        setUpTableView()
    }
    
    @objc private func back() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: true)
    }
}

//MARK: - TableView

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationTableViewCell.self), for: indexPath) as! NotificationTableViewCell
        cell.configure(notificationArray: notifications[indexPath.row])
        
        return cell
    }
}
