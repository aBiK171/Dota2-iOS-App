//
//  HeroStatGridView.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//
import UIKit

final class HeroStatGridView: UIView {
    
    private let stackView = UIStackView()
    private let loreTitleLabel = UILabel()
    private let loreLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(stackView)
        
        
        loreTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        loreTitleLabel.textColor = .white
        loreTitleLabel.text = "About hero:"

        loreLabel.font = .systemFont(ofSize: 15)
        loreLabel.textColor = .systemGray2
        loreLabel.numberOfLines = 0
        

       
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func configure(with hero: Hero) {
       
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stackView.addArrangedSubview(loreTitleLabel)
        stackView.addArrangedSubview(loreLabel)
        loreLabel.text = hero.lore
        let stats: [(UIImage?, String, String)] = [
            
            (UIImage(systemName: "flame.fill"), "STR", "\(hero.strength) + \(hero.strGain)"),
            (UIImage(systemName: "leaf.fill"), "AGI", "\(hero.agility) + \(hero.agiGain)"),
            (UIImage(systemName: "sparkles"), "INT", "\(hero.intelligence) + \(hero.intGain)"),
            
            (UIImage(systemName: "shield.fill"), "Armor", "\(hero.armor ?? 0)"),
            (UIImage(systemName: "bolt.fill"), "Magic Res", "\(hero.baseMr ?? 0)%"),
            (UIImage(systemName: "figure.walk"), "Speed", "\(hero.speed)"),
            
            (UIImage(systemName: "scope"), "Range", "\(hero.attackRange)"),
            (UIImage(systemName: "sun.max.fill"), "Day Vision", "\(hero.dayVision)"),
            (UIImage(systemName: "moon.fill"), "Night Vision", "\(hero.nightVision)")
        ]
        
        var rowStack: UIStackView?
        
        for (index, stat) in stats.enumerated() {
            
            if index % 3 == 0 {
                rowStack = UIStackView()
                rowStack?.axis = .horizontal
                rowStack?.spacing = 12
                rowStack?.distribution = .fillEqually
                stackView.addArrangedSubview(rowStack!)
            }
            
            let item = HeroStatView()
            item.configure(icon: stat.0, title: stat.1, value: stat.2)
            
            rowStack?.addArrangedSubview(item)
        }
       
    }
}
