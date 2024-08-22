//
//  TabBarItemView.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation
import UIKit
import SnapKit

protocol TabBarItemViewDelegate: AnyObject {
    func tapHandler(_ view: TabBarItemView)
}

class TabBarItemView: UIView {
    
    // MARK: - Properties
    
    private let image: String
    private let title: String
    weak var delegate: TabBarItemViewDelegate?
    private let selectedColor: UIColor = .orange
    private let normalColor: UIColor = .gray
    public var isSelected: Bool = false {
        willSet {
            updateUI(isSelected: newValue)
        }
    }
    
    // MARK: - Init
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
        super.init(frame: .zero)
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    // MARK: - Methods
    
    private func updateUI(isSelected: Bool) {
        iconImageView.tintColor = isSelected ? selectedColor : normalColor
        titleLabel.textColor = isSelected ? selectedColor : normalColor
    }
    
    // MARK: - UIElements
    
    private let containerView = UIView()
    
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: image)
        iv.tintColor = normalColor
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.text = title
        label.textColor = normalColor
        return label
    }()
    
    // MARK: - Setup View

    private func setupView() {
        backgroundColor = .clear
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        addSubview(containerView)
    }
    
    private func         setConstraint() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(0)
            make.centerX.equalTo(iconImageView.snp.centerX)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

// MARK: - Gesture

extension TabBarItemView {
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleGesture(_ sender: UITapGestureRecognizer) {
        delegate?.tapHandler(self)
    }
}

