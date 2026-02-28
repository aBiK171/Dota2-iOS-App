//
//  ProPlayersCell.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 24/02/26.
//

import UIKit
import Kingfisher

class ProPlayersCell: UICollectionViewCell {
    
    static let proPlayerId = "ProPlayersId"
    
    private let imagePlayer = UIImageView()
    private let imageLogoTeam = UIImageView()
    private let labelTeamName = UILabel()
    private let labelTeamTag = UILabel()
    private let labelName = UILabel()
    private let labelCountry = UILabel()
    private let mainStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        contentView.backgroundColor = UIColor(named: "colorBlack")
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        imagePlayer.contentMode = .scaleAspectFill
        imagePlayer.layer.cornerRadius = 10
        imagePlayer.clipsToBounds = true
        imagePlayer.translatesAutoresizingMaskIntoConstraints = false

        imageLogoTeam.contentMode = .scaleAspectFit
        imageLogoTeam.translatesAutoresizingMaskIntoConstraints = false

        labelName.textColor = UIColor(named: "colorWhite")
        labelName.font = .preferredFont(forTextStyle: .headline)
        labelName.adjustsFontForContentSizeCategory = true
        
        labelTeamTag.textColor = UIColor(named: "colorWhite")
        labelTeamTag.font = .boldSystemFont(ofSize: 14)
        labelTeamTag.textAlignment = .center
        
        labelTeamName.textColor = UIColor(named: "colorWhite")
        labelTeamName.adjustsFontSizeToFitWidth = true
        labelTeamName.minimumScaleFactor = 0.7
        labelTeamName.numberOfLines = 1
        
        labelCountry.textColor = UIColor(named: "colorWhite")
        labelCountry.font = .systemFont(ofSize: 12)
        labelCountry.textAlignment = .center
       
     
        mainStack.axis = .vertical

   
        mainStack.addArrangedSubview(imagePlayer)

        // row1
        let row1 = UIStackView(arrangedSubviews: [imageLogoTeam, labelName])
        row1.axis = .horizontal
        row1.spacing = 6
        row1.distribution = .fillEqually
        

        // row2
        let row2 = UIStackView(arrangedSubviews: [labelTeamTag, labelTeamName])
        row2.axis = .horizontal
        row2.spacing = 6
        row2.distribution = .fillEqually
        
        mainStack.axis = .vertical
        mainStack.spacing = 6
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        mainStack.addArrangedSubview(imagePlayer)
        mainStack.addArrangedSubview(row1)
        mainStack.addArrangedSubview(row2)

        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            
            imagePlayer.heightAnchor.constraint(equalToConstant: 220),

            imageLogoTeam.widthAnchor.constraint(equalToConstant: 30),
            imageLogoTeam.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 18
        
        contentView.applyGradientBorder(
            colors: [
                .systemPurple,
                .systemBlue,
                .systemTeal
            ],
            lineWidth: 2
        )
    }
    func configure(with model: LocalProPlayer) {
        imagePlayer.image = UIImage(named: model.playerImage)
        imageLogoTeam.image = UIImage(named: model.teamLogo)
        
        labelName.text = model.name
        labelTeamTag.text = model.teamTag
        labelTeamName.text = model.teamName
    }
}
