//
//  CutomNavBarView.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

final class CustomNavBarView: UIView {
    
    private let centerButton = UIButton()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let badgeLabel = UILabel()
    
    var onRightTap: (() -> Void)?
    var onLeftTap: (() -> Void)?
    
    enum CenterContent {
        case button(UIImage?)
        case title(String)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centerButton)
        
        leftButton.tintColor = UIColor(named: "colorWhite")
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.addTarget(self, action: #selector(didTapLeft), for: .touchUpInside)
        addSubview(leftButton)
        
        rightButton.tintColor = UIColor(named: "colorWhite")
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.addTarget(self, action: #selector(didTapRight), for: .touchUpInside)
        addSubview(rightButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 25),
            leftButton.heightAnchor.constraint(equalTo: leftButton.widthAnchor),
            
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 30),
            rightButton.heightAnchor.constraint(equalTo: rightButton.widthAnchor)
        ])
    }
    
    @objc private func didTapLeft() {
        onLeftTap?()
    }
    
    @objc private func didTapRight() {
        onRightTap?()
    }
    
    
    
    func configure(center: CenterContent, leftImage: UIImage?, rightImage: UIImage?) {
        
        leftButton.setImage(leftImage, for: .normal)
        rightButton.setImage(rightImage, for: .normal)

        centerButton.setImage(nil, for: .normal)
        centerButton.setTitle(nil, for: .normal)

        switch center {
            
        case .button(let image):
            centerButton.setImage(image, for: .normal)
            NSLayoutConstraint.activate([
                centerButton.widthAnchor.constraint(equalToConstant: 45),
                centerButton.heightAnchor.constraint(equalTo: centerButton.widthAnchor)
            ])

        case .title(let text):
            centerButton.setTitle(text, for: .normal)
            centerButton.setTitleColor(.white, for: .normal)
            centerButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
            
            NSLayoutConstraint.activate([
                centerButton.leadingAnchor.constraint(greaterThanOrEqualTo: leftButton.trailingAnchor, constant: 16),
                centerButton.trailingAnchor.constraint(lessThanOrEqualTo: rightButton.leadingAnchor, constant: -16)
            ])
        }
    }
}
