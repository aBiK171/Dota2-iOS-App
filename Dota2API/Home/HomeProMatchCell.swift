import UIKit
import Kingfisher

final class HomeProMatchCell: UICollectionViewCell {

    static let reuseId = "HomeProMatchCell"

    private let cardView = UIView()

    private let leagueLabel = UILabel()

    private let radiantLogo = UIImageView()
    private let direLogo = UIImageView()

    private let radiantName = UILabel()
    private let direName = UILabel()

    private let scoreLabel = UILabel()
    private let durationLabel = UILabel()

    private let divider = UIView()

    private let topStack = UIStackView()
    private let middleStack = UIStackView()
    private let bottomStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        backgroundColor = .clear

        // Card
        cardView.backgroundColor = UIColor(red: 28/255, green: 24/255, blue: 16/255, alpha: 0.95)
        cardView.layer.cornerRadius = 24
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.systemYellow.withAlphaComponent(0.35).cgColor
        cardView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        setupTop()
        setupMiddle()
        setupBottom()
    }

    private func setupTop() {

        leagueLabel.font = .boldSystemFont(ofSize: 13)
        leagueLabel.textColor = .systemYellow

        topStack.axis = .horizontal
        topStack.alignment = .center
        topStack.translatesAutoresizingMaskIntoConstraints = false

        topStack.addArrangedSubview(leagueLabel)

        cardView.addSubview(topStack)

        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            topStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            topStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
    }

    private func setupMiddle() {

        [radiantLogo, direLogo].forEach {
            $0.contentMode = .scaleAspectFit
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }

        radiantName.font = .systemFont(ofSize: 14, weight: .medium)
        radiantName.textColor = .white
        radiantName.textAlignment = .center
        radiantName.numberOfLines = 1

        direName.font = .systemFont(ofSize: 14, weight: .medium)
        direName.textColor = .white
        direName.textAlignment = .center
        direName.numberOfLines = 1

        scoreLabel.font = .boldSystemFont(ofSize: 22)
        scoreLabel.textColor = .systemGreen
        scoreLabel.textAlignment = .center

        let leftStack = UIStackView(arrangedSubviews: [radiantLogo, radiantName])
        leftStack.axis = .vertical
        leftStack.alignment = .center
        leftStack.spacing = 6

        let rightStack = UIStackView(arrangedSubviews: [direLogo, direName])
        rightStack.axis = .vertical
        rightStack.alignment = .center
        rightStack.spacing = 6

        middleStack.axis = .horizontal
        middleStack.alignment = .center
        middleStack.distribution = .equalSpacing
        middleStack.translatesAutoresizingMaskIntoConstraints = false

        middleStack.addArrangedSubview(leftStack)
        middleStack.addArrangedSubview(scoreLabel)
        middleStack.addArrangedSubview(rightStack)

        cardView.addSubview(middleStack)

        NSLayoutConstraint.activate([
            middleStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            middleStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            middleStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24)
        ])

        divider.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        divider.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: middleStack.bottomAnchor, constant: 20),
            divider.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func setupBottom() {

        durationLabel.font = .systemFont(ofSize: 13, weight: .medium)
        durationLabel.textColor = .lightGray
        durationLabel.textAlignment = .center

        bottomStack.axis = .horizontal
        bottomStack.alignment = .center
        bottomStack.translatesAutoresizingMaskIntoConstraints = false

        bottomStack.addArrangedSubview(durationLabel)

        cardView.addSubview(bottomStack)

        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12),
            bottomStack.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }

    func configure(with model: MatchOverview) {

        leagueLabel.text = model.leagueName
        radiantName.text = model.radiantTeam
        direName.text = model.direTeam
        scoreLabel.text = model.scoreText ?? "-"
        durationLabel.text = model.timeText

        if let radiantLogoURL = model.radiantLogo,
           let url = URL(string: radiantLogoURL) {
            radiantLogo.kf.setImage(with: url)
        } else {
            radiantLogo.image = UIImage(systemName: "shield")
        }

        if let direLogoURL = model.direLogo,
           let url = URL(string: direLogoURL) {
            direLogo.kf.setImage(with: url)
        } else {
            direLogo.image = UIImage(systemName: "shield")
        }
    }
}
