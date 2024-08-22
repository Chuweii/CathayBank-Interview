//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
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
        addSubview(titleLabel)
        addSubview(eyeButton)
        addSubview(usdTitleLabel)
        addSubview(usdSubTitleLabel)
        addSubview(usdSubHideTiteLabel)
        addSubview(khrTitleLabel)
        addSubview(khrSubTitleLabel)
        addSubview(khrSubHideTiteLabel)
        eyeButton.addTarget(self, action: #selector(eyeAmountAction), for: .touchUpInside)
    }
    
    private func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.width.equalTo(24)
        }
        
        usdTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        // show
        usdSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usdTitleLabel.snp.bottom)
            make.leading.equalTo(usdTitleLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
        }
        
        // hide
        usdSubHideTiteLabel.snp.makeConstraints { make in
            make.top.equalTo(usdTitleLabel.snp.bottom)
            make.leading.equalTo(usdTitleLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
        }
        
        // show
        khrTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usdSubTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(usdSubTitleLabel.snp.leading)
        }
        
        // hide
        khrSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(khrTitleLabel.snp.bottom)
            make.leading.equalTo(khrTitleLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        khrSubHideTiteLabel.snp.makeConstraints { make in
            make.top.equalTo(khrTitleLabel.snp.bottom)
            make.leading.equalTo(khrTitleLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
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
