//
//  TabBarViewController.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import UIKit

class TabBarViewController: UIViewController {
    /// View Controller Type
    enum ViewControllerPage: Int {
        case Home
        case Account
        case Location
        case Service
    }
        
    // MARK: - Model
    
    private let tabItems = [
        TabItem(icon: "icon_home", title: "Home"),
        TabItem(icon: "icon_account", title: "Account"),
        TabItem(icon: "icon_location", title: "Location"),
        TabItem(icon: "icon_service", title: "Service")
    ]
    
    // MARK: - Properties
    
    private var currentIndex = 0
    private let bottomStackHeight: CGFloat = 50

    // MARK: - UI Component
    
    private lazy var homeViewController = UINavigationController(rootViewController: HomeViewController())
    private let bottomStack = UIStackView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews(pageIndex: ViewControllerPage(rawValue: currentIndex) ?? .Home)
    }
    
    // MARK: - Setup View
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(homeViewController.view)
        homeViewController.didMove(toParent: self)
        createItem()
        setupBottomStack()
    }
    
    private func createItem() {
        tabItems.forEach { model in
            let itemView = TabBarItemView(image: model.icon, title: model.title)
            itemView.isSelected = false
            itemView.delegate = self
            bottomStack.addArrangedSubview(itemView)
        }
        
        let itemView = bottomStack.arrangedSubviews[currentIndex] as! TabBarItemView
        itemView.isSelected = true
    }
    
    private func setupBottomStack() {
        bottomStack.backgroundColor = .white
        bottomStack.axis = .horizontal
        bottomStack.spacing = 5
        bottomStack.alignment = .fill
        bottomStack.distribution = .fillEqually
        bottomStack.layer.cornerRadius = 26
        bottomStack.layer.shadowColor = UIColor.gray.cgColor
        bottomStack.layer.shadowOpacity = 0.5
        bottomStack.layer.shadowOffset = CGSize(width: 0, height: 2)
        bottomStack.layer.shadowRadius = 5
        bottomStackLayout()
    }
    
    private func bottomStackLayout() {
        view.addSubview(bottomStack)
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -22),
            bottomStack.heightAnchor.constraint(equalToConstant: bottomStackHeight)
        ])
    }
    
    private func updateViews(pageIndex: ViewControllerPage) {
        switch pageIndex {
        case .Home:
            navigationController?.navigationBar.isHidden = true
            viewLayout(view: homeViewController.view)
        default:
            break
        }
    }
    
    func viewLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - TabBarItemViewDelegate

extension TabBarViewController: TabBarItemViewDelegate {
    func tapHandler(_ view: TabBarItemView) { }
}
