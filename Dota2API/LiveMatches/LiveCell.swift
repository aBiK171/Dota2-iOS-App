//
//  LiveCell.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 25/02/26.
//

import UIKit

final class LiveCell: UICollectionViewCell {
    
    static let identifier = "LiveCell"
    
    private let containerView = UIView()
    private let scoreLabel = UILabel()
    private let statusLabel = UILabel()
    private let leagueLabel = UILabel()
    private let leagueLogo = UIImageView()
    private let radiantLabel = UILabel()
    private let direLabel = UILabel()
    private let radiantLogo = UIImageView()
    private let direLogo = UIImageView()
    private let timeLabel = UILabel()
    private let colonLabel = UILabel()
    private var mainStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    private func setupUI() {
        containerView.backgroundColor = UIColor(named: "colorSection")?.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 16
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        leagueLabel.textColor = UIColor(named: "colorWhite")
        leagueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        leagueLabel.textAlignment = .left
        
        
        leagueLogo.translatesAutoresizingMaskIntoConstraints = false
        leagueLogo.contentMode = .scaleAspectFit
        
        
        radiantLogo.contentMode = .scaleAspectFill
        radiantLogo.translatesAutoresizingMaskIntoConstraints = false
        radiantLogo.tintColor = UIColor(named: "colorWhite")
        
        direLogo.contentMode = .scaleAspectFill
        direLogo.translatesAutoresizingMaskIntoConstraints = false
        
       
        scoreLabel.textColor = UIColor(named: "colorWhite")
        scoreLabel.font = .systemFont(ofSize: 18, weight: .bold)
        scoreLabel.textAlignment = .center
        
        statusLabel.textColor = UIColor(named: "colorWhite")
        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = 6
        statusLabel.layer.masksToBounds = true
        statusLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        
        radiantLabel.textColor = UIColor(named: "colorWhite")
        radiantLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        direLabel.textColor = UIColor(named: "colorWhite")
        direLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        timeLabel.textColor = UIColor(named: "colorWhite")
        timeLabel.font = .monospacedDigitSystemFont(ofSize: 16, weight: .medium)
        timeLabel.textAlignment = .center
        
        let leagueRow = UIStackView(arrangedSubviews: [leagueLogo, leagueLabel, statusLabel])
        leagueRow.axis = .horizontal
        leagueRow.spacing = 8
        leagueRow.alignment = .center
        leagueRow.distribution = .fillProportionally
        
        let middleRow = UIStackView(arrangedSubviews: [radiantLogo, colonLabel, direLogo])
        middleRow.axis = .horizontal
        middleRow.distribution = .equalCentering
        middleRow.spacing = 10
        
        let nameRow = UIStackView(arrangedSubviews: [radiantLabel, direLabel])
        nameRow.axis = .horizontal
        nameRow.spacing = 10
        nameRow.distribution = .equalSpacing
        
        
        
        mainStack = UIStackView(arrangedSubviews: [leagueRow, middleRow, nameRow, timeLabel])
        mainStack.axis = .vertical
        mainStack.spacing = 20
        
        
   
        
        
        
        containerView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leagueLogo.widthAnchor.constraint(equalToConstant: 25),
            leagueLogo.heightAnchor.constraint(equalToConstant: 25),
            
            radiantLogo.widthAnchor.constraint(equalToConstant: 60),
            radiantLogo.heightAnchor.constraint(equalToConstant: 60),
            direLogo.widthAnchor.constraint(equalToConstant: 60),
            direLogo.heightAnchor.constraint(equalToConstant: 60),
            
            statusLabel.widthAnchor.constraint(equalToConstant: 50),
            
            mainStack.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10)
        ])
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = 18
        containerView.clipsToBounds = true   // 👈 MUHIM

        containerView.applyGradientBorder(
            colors: [.purple, .white, .red],
            lineWidth: 2
        )
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with match: MatchOverview) {
        scoreLabel.text = match.scoreText
        statusLabel.backgroundColor = match.statusText == "RUNNING" ? .systemRed : .gray
        statusLabel.text = match.statusText == "RUNNING" ? "LIVE" : "SOON"
        statusLabel.textColor = UIColor(named: "colorWhite")
        
        leagueLabel.text = match.leagueName
        radiantLabel.text = match.radiantTeam
        direLabel.text = match.direTeam
        if let urlString = match.leagueLogo,
           let url = URL(string: urlString) {
            leagueLogo.kf.setImage(with: url)
        } else {
            leagueLogo.image = UIImage(systemName: "trophy.fill")?.withRenderingMode(.alwaysTemplate)
            leagueLogo.tintColor = UIColor(named: "colorWhite")
        }
        
        if let urlString = match.radiantLogo,
           let url = URL(string: urlString) {
            radiantLogo.kf.setImage(with: url)
        }
        if let urlString = match.direLogo,
           let url = URL(string: urlString) {
            direLogo.kf.setImage(with: url)
        }
        timeLabel.text = match.timeText
    }
}
