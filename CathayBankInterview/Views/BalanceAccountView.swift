//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation
import UIKit

class BalanceAccountView: UIView {
    private var isShowAmount: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Account Balance"
        label.textColor = .gray100
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "iconEye01On")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let usdTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = .gray300
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usdSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "loaging..."
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usdSubHideTiteLabel: UILabel = {
        let label = UILabel()
        label.text = "********"
        label.isHidden = true
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let khrTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "KHR"
        label.textColor = .gray300
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let khrSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "loaging..."
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let khrSubHideTiteLabel: UILabel = {
        let label = UILabel()
        label.text = "********"
        label.isHidden = true
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - setup

    private func setupViews() {
        let allViews = [titleLabel, eyeButton, usdTitleLabel, usdSubTitleLabel, usdSubHideTiteLabel, khrTitleLabel, khrSubTitleLabel, khrSubHideTiteLabel]
        
        allViews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        eyeButton.addTarget(self, action: #selector(eyeAmountAction), for: .touchUpInside)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            // Eye button constraints
            eyeButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            eyeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            eyeButton.heightAnchor.constraint(equalToConstant: 24),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            
            // USD title label constraints
            usdTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            usdTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            // USD subtitle label constraints (show)
            usdSubTitleLabel.topAnchor.constraint(equalTo: usdTitleLabel.bottomAnchor),
            usdSubTitleLabel.leadingAnchor.constraint(equalTo: usdTitleLabel.leadingAnchor),
            usdSubTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            // USD subtitle label constraints (hide)
            usdSubHideTiteLabel.topAnchor.constraint(equalTo: usdTitleLabel.bottomAnchor),
            usdSubHideTiteLabel.leadingAnchor.constraint(equalTo: usdTitleLabel.leadingAnchor),
            usdSubHideTiteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            // KHR title label constraints
            khrTitleLabel.topAnchor.constraint(equalTo: usdSubTitleLabel.bottomAnchor, constant: 8),
            khrTitleLabel.leadingAnchor.constraint(equalTo: usdSubTitleLabel.leadingAnchor),
            
            // KHR subtitle label constraints (show)
            khrSubTitleLabel.topAnchor.constraint(equalTo: khrTitleLabel.bottomAnchor),
            khrSubTitleLabel.leadingAnchor.constraint(equalTo: khrTitleLabel.leadingAnchor),
            khrSubTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            khrSubTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            // KHR subtitle label constraints (hide)
            khrSubHideTiteLabel.topAnchor.constraint(equalTo: khrTitleLabel.bottomAnchor),
            khrSubHideTiteLabel.leadingAnchor.constraint(equalTo: khrTitleLabel.leadingAnchor),
            khrSubHideTiteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            khrSubHideTiteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    @objc
    func eyeAmountAction() {
        if isShowAmount {
            let image = UIImage(named: "iconEye02Off")
            eyeButton.setImage(image, for: .normal)
            isShowAmount = false
            
            usdSubTitleLabel.isHidden = true
            khrSubTitleLabel.isHidden = true
            
            usdSubHideTiteLabel.isHidden = false
            khrSubHideTiteLabel.isHidden = false
        } else {
            let image = UIImage(named: "iconEye01On")
            eyeButton.setImage(image, for: .normal)
            isShowAmount = true
            
            usdSubTitleLabel.isHidden = false
            khrSubTitleLabel.isHidden = false
            
            usdSubHideTiteLabel.isHidden = true
            khrSubHideTiteLabel.isHidden = true
        }
    }
    
    func configure(usdTotal: String, khrTotal: String) {
        usdSubTitleLabel.text = usdTotal
        khrSubTitleLabel.text = khrTotal
    }
}
