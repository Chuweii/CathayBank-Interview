//
//  HomeViewController.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: HomeViewModel = .init()
    private let refreshControl: UIRefreshControl = .init()
    private var cancellables: Set<AnyCancellable> = .init()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        Task {
            await viewModel.onAppear()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraint()
    }
    
    // MARK: - Setup View

    private func setupView() {
        view.addSubview(userImageView)
        view.addSubview(notificationButton)
        view.addSubview(scrollView)
        scrollView.addSubview(balanceAccountView)
        scrollView.addSubview(myFavoriteView)
        scrollView.addSubview(adBannerView)
        
        // Set translatesAutoresizingMaskIntoConstraints to false for all views
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        balanceAccountView.translatesAutoresizingMaskIntoConstraints = false
        myFavoriteView.translatesAutoresizingMaskIntoConstraints = false
        adBannerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setBinding() {
        viewModel.$isFirstLogin
            .filter { !$0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                let image = UIImage(named: "iconBell02Active")
                notificationButton.setImage(image, for: .normal)
                notificationButton.addTarget(self, action: #selector(notificationAction), for: .touchUpInside)
            }
            .store(in: &cancellables)
        
        viewModel.$usdAmount
            .receive(on: DispatchQueue.main)
            .combineLatest(viewModel.$khrAmount)
            .sink { [weak self] usd, khr in
                self?.balanceAccountView.configure(usdTotal: usd, khrTotal: khr)
            }
            .store(in: &cancellables)
        
        viewModel.$favorites
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .combineLatest(viewModel.$isFirstLogin)
            .sink { [weak self] favorites, isFirstLogin in
                guard let self else { return }
                myFavoriteView.configure(isFirstLogin: isFirstLogin, favorites: favorites)
            }
            .store(in: &cancellables)
        
        viewModel.$banners
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] banners in
                guard let self else { return }
                adBannerView.configure(isFirstLogin: viewModel.isFirstLogin, adBanners: banners)
            }
            .store(in: &cancellables)
    }
    
    private func setConstraint() {
        let verticalSpacing: CGFloat = 5
        let horizontalSpacing: CGFloat = 24
        let buttonSize: CGFloat = 24
        let userImageViewSize: CGFloat = 40

        NSLayoutConstraint.activate([
            // User image view constraints
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalSpacing),
            userImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacing),
            userImageView.heightAnchor.constraint(equalToConstant: userImageViewSize),
            userImageView.widthAnchor.constraint(equalToConstant: userImageViewSize),
            
            // Notification button constraints
            notificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing),
            notificationButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            notificationButton.heightAnchor.constraint(equalToConstant: buttonSize),
            notificationButton.widthAnchor.constraint(equalToConstant: buttonSize),
            
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: verticalSpacing),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Balance account view constraints
            balanceAccountView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            balanceAccountView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            balanceAccountView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // My favorite view constraints
            myFavoriteView.topAnchor.constraint(equalTo: balanceAccountView.bottomAnchor),
            myFavoriteView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            myFavoriteView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // Ad banner view constraints
            adBannerView.topAnchor.constraint(equalTo: myFavoriteView.bottomAnchor),
            adBannerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            adBannerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            adBannerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    // MARK: - Methods
    
    @objc
    private func refreshData(_ sender: Any) {
        viewModel.isFirstLogin = false
        Task {
            await viewModel.onAppear()
        }
        refreshControl.endRefreshing()
    }
    
    @objc
    private func notificationAction() {
        let notificationVC = NotificationViewController(notifications: viewModel.notifications)
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    // MARK: - UI Component
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "iconBell01Nomal")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sc: UIScrollView = .init()
        sc.showsVerticalScrollIndicator = false
        sc.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return sc
    }()
    
    private let balanceAccountView = BalanceAccountView()
    
    private let myFavoriteView = MyFavoriteView()
    
    private let adBannerView = AdBannerView()
}
