//
//  LastMatchesCell.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

final class LastMatchesCell: UITableViewCell {

    static let lastMatchId = "LastMatchesCell"

    private let heroImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let kdaLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    
    private let textStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
    }

    private func setupUI() {

        selectionStyle = .none
        backgroundColor = .clear

        // HERO IMAGE
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.layer.cornerRadius = 6
        heroImageView.clipsToBounds = true
        heroImageView.contentMode = .scaleAspectFill
        contentView.addSubview(heroImageView)

        // LABELS
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(named: "colorWhite")

        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .lightGray

        kdaLabel.font = .boldSystemFont(ofSize: 16)
        kdaLabel.textColor = UIColor(named: "colorWhite")
        kdaLabel.textAlignment = .right
        kdaLabel.translatesAutoresizingMaskIntoConstraints = false

        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        contentView.addSubview(textStack)
        contentView.addSubview(kdaLabel)

        // PROGRESS
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemGreen
        progressView.trackTintColor = UIColor.white.withAlphaComponent(0.1)
        contentView.addSubview(progressView)

        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heroImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImageView.widthAnchor.constraint(equalToConstant: 60),
            heroImageView.heightAnchor.constraint(equalTo: heroImageView.widthAnchor),

            textStack.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 12),
            textStack.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor),

            kdaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            kdaLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            kdaLabel.leadingAnchor.constraint(greaterThanOrEqualTo: textStack.trailingAnchor, constant: 8),

            progressView.leadingAnchor.constraint(equalTo: textStack.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: kdaLabel.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func setImage(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.heroImageView.image = image
            }
        }.resume()
    }
    
    func configure(heroName: String, subtitle: String, kills: Int,progress: Float, deaths: Int, assists: Int, image: UIImage?) {
        titleLabel.text = heroName
        subtitleLabel.text = subtitle
        kdaLabel.text = "\(kills) / \(deaths) / \(assists)"
        progressView.setProgress(progress, animated: true)
        heroImageView.image = image
    }
}
