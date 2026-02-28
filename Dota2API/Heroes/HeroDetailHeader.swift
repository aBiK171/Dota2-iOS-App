//
//  HeroDetailHeader.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//

import UIKit
import Kingfisher

final class HeroHeaderView: UIView {
    
    private let containerView = UIView()
    private let heroImageView = UIImageView()
    
    private let nameLabel = UILabel()
    private let hpLabel = UILabel()
    private let hpLogo = UIButton()
    private let mpLogo = UIButton()
    
    private let hpBar = StatBarView()
    private let mpBar = StatBarView()
    
    private let mpLabel = UILabel()
    private let attrImageView = UIImageView()
    private let rolesLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    private func setupUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 18
        containerView.clipsToBounds = true
        
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        nameLabel.textColor = .white
        
        hpLogo.setImage(UIImage(named: "iconHealth")?.withRenderingMode(.alwaysTemplate), for: .normal)
        hpLogo.tintColor = .red
        hpLogo.translatesAutoresizingMaskIntoConstraints = false
        
        mpLogo.setImage(UIImage(named: "iconMana")?.withRenderingMode(.alwaysTemplate), for: .normal)
        mpLogo.tintColor = .systemBlue
        mpLogo.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        hpLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        hpLabel.textColor = .red
        
        mpLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        mpLabel.textColor = .systemBlue
        
        rolesLabel.font = .systemFont(ofSize: 17)
        rolesLabel.textColor = .systemGray3
        rolesLabel.numberOfLines = 0
        
        attrImageView.translatesAutoresizingMaskIntoConstraints = false
        attrImageView.contentMode = .scaleAspectFit
        
        let hpRow = UIStackView(arrangedSubviews: [hpLogo, hpBar])
        hpRow.axis = .horizontal
        hpRow.spacing = 10
        
        let mpRow = UIStackView(arrangedSubviews: [mpLogo, mpBar])
        mpRow.axis = .horizontal
        mpRow.spacing = 10
        
        
        
        let textStack = UIStackView(arrangedSubviews: [
            nameLabel,
            hpRow,
            mpRow,
            rolesLabel
        ])
        
        textStack.axis = .vertical
        textStack.spacing = 22
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(heroImageView)
        containerView.addSubview(textStack)
        containerView.addSubview(attrImageView)
        
        NSLayoutConstraint.activate([
            hpLogo.widthAnchor.constraint(equalToConstant: 20),
            hpLogo.heightAnchor.constraint(equalTo: hpLogo.widthAnchor),
            
            mpLogo.widthAnchor.constraint(equalToConstant: 20),
            mpLogo.heightAnchor.constraint(equalTo: hpLogo.widthAnchor),
            
            heroImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 220),
            
            textStack.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 16),
            textStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            attrImageView.topAnchor.constraint(equalTo: textStack.topAnchor),
            attrImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            attrImageView.widthAnchor.constraint(equalToConstant: 28),
            attrImageView.heightAnchor.constraint(equalToConstant: 28),
            
            rolesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with hero: Hero) {
        
        nameLabel.text = hero.name
        
        hpBar.configure(value: "\(hero.totalHP) + \(hero.strGain)", color: UIColor(named: "colorGreen") ?? .systemGreen)
        mpBar.configure(value: "\(hero.totalMana) + \(hero.intGain)", color: UIColor(named: "colorBlue") ?? .systemBlue)
        
        hpLabel.text = "\(hero.totalHP) + \(hero.strGain)"
        mpLabel.text = "\(hero.totalMana) + \(hero.intGain)"
        
        rolesLabel.text = hero.roles.joined(separator: " • ")
        
        if let url = hero.fullImageURL {
            heroImageView.kf.setImage(with: url)
        }
        
        attrImageView.image = attributeIcon(for: hero.attribute)
    }
    
    
    
    private func attributeIcon(for attr: String) -> UIImage? {
        switch attr {
        case "str":
            return UIImage(named: "icon_str")
        case "agi":
            return UIImage(named: "icon_agi")
        case "int":
            return UIImage(named: "icon_int")
        default:
            return nil
        }
    }
}
