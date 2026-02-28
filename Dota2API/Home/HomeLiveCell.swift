import UIKit

final class HomeLiveCell: UICollectionViewCell {

    static let reuseId = "HomeLiveCell"

    private let containerView = UIView()

    private let leagueLabel = UILabel()
    private let liveBadge = UILabel()

    private let radiantLabel = UILabel()
    private let direLabel = UILabel()
    private let scoreLabel = UILabel()

    private let mainStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        backgroundColor = .clear

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        containerView.backgroundColor = UIColor.orange.withAlphaComponent(0.2)
        containerView.layer.cornerRadius = 24
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemYellow.withAlphaComponent(0.35).cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        leagueLabel.font = .systemFont(ofSize: 14, weight: .medium)
        leagueLabel.textColor = .white

        liveBadge.text = "LIVE"
        liveBadge.font = .systemFont(ofSize: 12, weight: .bold)
        liveBadge.textAlignment = .center
        liveBadge.textColor = .white
        liveBadge.backgroundColor = .systemRed
        liveBadge.layer.cornerRadius = 10
        liveBadge.clipsToBounds = true
        liveBadge.translatesAutoresizingMaskIntoConstraints = false

        radiantLabel.font = .systemFont(ofSize: 16, weight: .medium)
        radiantLabel.textColor = .white
        radiantLabel.textAlignment = .center

        direLabel.font = .systemFont(ofSize: 16, weight: .medium)
        direLabel.textColor = .white
        direLabel.textAlignment = .center

        scoreLabel.font = .systemFont(ofSize: 26, weight: .bold)
        scoreLabel.textColor = .systemGreen
        scoreLabel.textAlignment = .center

        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        mainStack.addArrangedSubview(leagueLabel)
        mainStack.addArrangedSubview(radiantLabel)
        mainStack.addArrangedSubview(scoreLabel)
        mainStack.addArrangedSubview(direLabel)

        containerView.addSubview(mainStack)
        containerView.addSubview(liveBadge)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            liveBadge.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            liveBadge.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            liveBadge.widthAnchor.constraint(equalToConstant: 55),
            liveBadge.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure(with model: MatchOverview) {

        leagueLabel.text = model.leagueName ?? "LIVE MATCH"
        radiantLabel.text = model.radiantTeam
        direLabel.text = model.direTeam
        scoreLabel.text = model.scoreText ?? "0 : 0"
    }
}
