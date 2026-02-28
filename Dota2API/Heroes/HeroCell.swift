//
//  HeroCell.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 26/02/26.
//

import UIKit
import Kingfisher

final class HeroCell: UICollectionViewCell {
    
    static let heroID = "HeroCell"
    
    private let containerView = UIView()
    private let heroImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
    }
    
    private func setupUI() {
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        containerView.layer.cornerRadius = 14
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        containerView.addSubview(heroImageView)
        containerView.addSubview(nameLabel)
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.clipsToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.6
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 1
    
        nameLabel.textColor = UIColor(named: "colorWhite")
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.75),
            
            nameLabel.topAnchor.constraint(lessThanOrEqualTo: heroImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = 18
        containerView.clipsToBounds = true   // 👈 MUHIM

        containerView.applyGradientBorder(
            colors: [.white, .systemBlue, .white],
            lineWidth: 0.75
        )
    }
    
    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        
        if let url = hero.fullImageURL {
            print("Loading:", url)   // 👈 tekshir
            heroImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [.transition(.fade(0.2))]
            )
        }
    }
}
