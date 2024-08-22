//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation
import UIKit

class AdBannerView: UIView {
    private var adBanners: [BannerModel] = []
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
        setUpCollcetionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private func setupViews() {
        let viewsToAdd: [UIView] = [
            collectionView,
            pageControl,
        ]
        viewsToAdd.forEach { self.addSubview($0) }
    }
    
    private func setConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.height.equalTo(100)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(4)
            make.leading.equalTo(collectionView.snp.leading)
            make.trailing.equalTo(collectionView.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-4)
            make.height.equalTo(20)
        }
    }
    
    private func setUpCollcetionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AdBannerCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AdBannerCollectionViewCell.self))
    }
    
    func configure(isFirstLogin: Bool, adBanners: [BannerModel]) {
        self.adBanners = adBanners
        collectionView.reloadData()
        if isFirstLogin {
            startAutoScroll()
        }
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNextPage() {
        let currentPage = pageControl.currentPage
        let nextPage = (currentPage + 1) % adBanners.count
        
        let nextIndexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        
        pageControl.currentPage = nextPage
    }
}

//MARK: - CollectionViewDelegate

extension AdBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adBanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdBannerCollectionViewCell.self), for: indexPath) as? AdBannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: adBanners[indexPath.row].linkUrl)
        pageControl.numberOfPages = adBanners.count
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width,
                      height: collectionView.bounds.height)
    }
}

//MARK: - UIScrollViewDelegate

extension AdBannerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.6
        pageControl.currentPage = Int(page)
    }
}

//MARK: - AdBannerCollectionViewCell

class AdBannerCollectionViewCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupViews() {
        contentView.addSubview(adImageView)
    }
    
    private func setConstraint() {
        adImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func configure(image: String) {
        adImageView.downloadImage(urlString: image) { result in
            switch result {
            case .success(let image):
                if let image = image {
                    self.adImageView.image = image
                } else {
                    let defaultImage = UIImage(named: "welcome_ad_default") ?? UIImage()
                    self.adImageView.image = defaultImage
                }
            case .failure(_):
                let defaultImage = UIImage(named: "welcome_ad_default") ?? UIImage()
                self.adImageView.image = defaultImage
            }
        }
    }
}
