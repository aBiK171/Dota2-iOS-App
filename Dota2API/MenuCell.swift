//
//  MenuCell.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

final class MenuCell: UITableViewCell {
    
    static let identifier = "MenuCell"
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let container = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        container.alpha = highlighted ? 0.6 : 1.0
    }
    private func setupUI() {
        self.selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        container.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        
        iconView.tintColor = .white
        iconView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(iconView)
        
        titleLabel.textColor = UIColor(named: "colorWhite")
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        
      
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
    
    func configure(with item: MenuItem, isActive: Bool) {
        iconView.image = UIImage(named: item.icon)?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = UIColor(named: "colorWhite")
        titleLabel.text = item.title
        
        if isActive {
            container.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        } else {
            container.backgroundColor = .clear
        }
    }
}
