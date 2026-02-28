//
//  WinrateCardView.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//

import UIKit

final class WinrateCardView: UIView {
    
    private let titleLabel = UILabel()
    private let winrateLabel = UILabel()
    private let picksLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .white
        
        winrateLabel.font = .systemFont(ofSize: 20, weight: .bold)
        winrateLabel.textColor = .white
        
        picksLabel.font = .systemFont(ofSize: 12)
        picksLabel.textColor = .white.withAlphaComponent(0.8)
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            winrateLabel,
            picksLabel
        ])
        
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func configure(title: String, winrate: Double, picks: Int, colors: [UIColor]) {
        
        titleLabel.text = title
        winrateLabel.text = String(format: "%.1f%%", winrate)
        picksLabel.text = "Picks: \(picks)"
        
        gradientLayer.removeFromSuperlayer()
        
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
