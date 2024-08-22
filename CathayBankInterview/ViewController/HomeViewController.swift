//
//  HomeViewController.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
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

        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(verticalSpacing)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(horizontalSpacing)
            make.height.width.equalTo(userImageViewSize)
        }

        notificationButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-horizontalSpacing)
            make.centerY.equalTo(userImageView.snp.centerY)
            make.height.width.equalTo(buttonSize)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(verticalSpacing)
            make.left.right.bottom.equalToSuperview()
        }
        
        balanceAccountView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
        }
        
        myFavoriteView.snp.makeConstraints { make in
            make.top.equalTo(balanceAccountView.snp.bottom)
            make.width.equalTo(view.snp.width)
        }
        
        adBannerView.snp.makeConstraints { make in
            make.top.equalTo(myFavoriteView.snp.bottom)
            make.width.equalTo(view.snp.width)
        }
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
        let vc = UINavigationController(rootViewController: NotificationViewController(notifications: viewModel.notifications))
        vc.modalPresentationStyle = .overFullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: true)
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
