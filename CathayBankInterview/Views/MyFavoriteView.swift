//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import UIKit

class MyFavoriteView: UIView {
    enum Option: String {
        case transfer = "Transfer"
        case payment = "Payment"
        case utility = "Utility"
        case qrPayScan = "QR pay scan"
        case myQRCode = "My QR code"
        case topup = "Topup"
    }
    
    private var views: [UIView] = []
    private var favorites: [FavoriteModel] = []
    private let stackSize: CGFloat = 96
    private let imageSize: CGFloat = 56
    private let btnImageSize: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setUpCollcetionView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI

    private let aStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Favorite"
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "More"
        label.textColor = .gray300
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconArrow01Next")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let defaultsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let defaultsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Defaults")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let defaultsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "- - -"
        label.textColor = .gray300
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let defaultsExplanationsLabel: UILabel = {
        let label = UILabel()
        label.text = "You can add a favorite through the transfer or payment function."
        label.textColor = .gray300
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func setupViews() {
        let viewsToAdd: [UIView] = [
            aStackView,
            bStackView,
            titleLabel,
            moreLabel,
            rightArrowImageView,
            collectionView,
            defaultsView,
        ]
        viewsToAdd.forEach { self.addSubview($0) }
        
        let viewsToAddDefaultsView: [UIView] = [
            defaultsImageView,
            defaultsTitleLabel,
            defaultsExplanationsLabel,
        ]
        viewsToAddDefaultsView.forEach { defaultsView.addSubview($0) }
    }
    
    func setConstraint() {
        aStackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(34)
            make.trailing.equalTo(self.snp.trailing).offset(-34)
            make.height.equalTo(stackSize)
        }

        bStackView.snp.makeConstraints { make in
            make.top.equalTo(aStackView.snp.bottom).offset(8)
            make.leading.equalTo(aStackView.snp.leading)
            make.trailing.equalTo(aStackView.snp.trailing)
            make.height.equalTo(stackSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bStackView.snp.bottom).offset(16)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.trailing.lessThanOrEqualTo(moreLabel.snp.leading)
        }

        moreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.lessThanOrEqualTo(rightArrowImageView.snp.leading)
        }

        rightArrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.centerY.equalTo(moreLabel.snp.centerY)
            make.height.width.equalTo(btnImageSize)
        }

        // use data show CollectionView
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(rightArrowImageView.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(88)
        }

        // no use dat show DefaultsView
        defaultsView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(rightArrowImageView.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }

        defaultsImageView.snp.makeConstraints { make in
            make.top.equalTo(defaultsView.snp.top).offset(2)
            make.leading.equalTo(defaultsView.snp.leading).offset(2)
            make.height.width.equalTo(imageSize)
        }

        defaultsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(defaultsImageView.snp.bottom).offset(2)
            make.leading.equalTo(defaultsView.snp.leading).offset(2)
            make.bottom.equalTo(defaultsView.snp.bottom)
            make.centerX.equalTo(defaultsImageView.snp.centerX)
        }

        defaultsExplanationsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(defaultsImageView.snp.centerY)
            make.leading.equalTo(defaultsImageView.snp.trailing).offset(12)
            make.trailing.equalTo(defaultsView.snp.trailing).offset(-2)
        }
    }
    
    private func setUpCollcetionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FavoriteCollectionViewCell.self))
    }
    
    private func updateStackView(option: Option, stackView: UIStackView) {
        let view = createButtonView(title: option.rawValue, image: option.rawValue)
        stackView.addArrangedSubview(view)
    }
    
    private func createButtonView(title: String, image: String) -> UIView {
        let containerView = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .gray300
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 13)

        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(2)
            make.centerX.equalTo(containerView)
            make.height.width.equalTo(imageSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.leading.equalTo(containerView).offset(2)
            make.trailing.equalTo(containerView).offset(-2)
            make.bottom.equalTo(containerView)
        }

        return containerView
    }
    
    func configure(isFirstLogin: Bool, favorites: [FavoriteModel]) {
        if isFirstLogin {
            // add button View
            updateStackView(option: .transfer, stackView: aStackView)
            updateStackView(option: .payment, stackView: aStackView)
            updateStackView(option: .utility, stackView: aStackView)
            
            updateStackView(option: .qrPayScan, stackView: bStackView)
            updateStackView(option: .myQRCode, stackView: bStackView)
            updateStackView(option: .topup, stackView: bStackView)
            
            collectionView.isHidden = isFirstLogin
            defaultsView.isHidden = !isFirstLogin
        } else {
            self.favorites = favorites
            collectionView.isHidden = false
            defaultsView.isHidden = true
        }
        collectionView.reloadData()
    }
}

extension MyFavoriteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteCollectionViewCell.self), for: indexPath) as! FavoriteCollectionViewCell
        
        cell.configure(title: favorites[indexPath.row].transType)
        
        return cell
    }
    
    /// UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 5,
               height: collectionView.bounds.height)
    }
}
