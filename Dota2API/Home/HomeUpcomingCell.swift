import UIKit
import Kingfisher

final class HomeUpcomingCell: UICollectionViewCell {

    static let reuseId = "HomeUpcomingCell"

    // MARK: - UI

    private let cardView = UIView()

    private let leagueLabel = UILabel()
    private let groupBadge = UILabel()

    private let radiantLogo = UIImageView()
    private let direLogo = UIImageView()

    private let radiantName = UILabel()
    private let direName = UILabel()

    private let vsLabel = UILabel()

    private let divider = UIView()

    private let clockIcon = UIImageView()
    private let timeLabel = UILabel()

    // Stacks
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

        groupBadge.font = .systemFont(ofSize: 11, weight: .bold)
        groupBadge.textColor = .black
        groupBadge.backgroundColor = .systemYellow
        groupBadge.layer.cornerRadius = 10
        groupBadge.clipsToBounds = true
        groupBadge.textAlignment = .center
        groupBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true

        topStack.axis = .horizontal
        topStack.alignment = .center
        topStack.spacing = 8
        topStack.translatesAutoresizingMaskIntoConstraints = false

        let spacer = UIView()

        topStack.addArrangedSubview(leagueLabel)
        topStack.addArrangedSubview(spacer)
        topStack.addArrangedSubview(groupBadge)

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
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }

        radiantName.font = .systemFont(ofSize: 14, weight: .medium)
        radiantName.textColor = .white
        radiantName.textAlignment = .center
        radiantName.numberOfLines = 1
        radiantName.lineBreakMode = .byTruncatingTail

        direName.font = .systemFont(ofSize: 14, weight: .medium)
        direName.textColor = .white
        direName.textAlignment = .center
        direName.numberOfLines = 1
        direName.lineBreakMode = .byTruncatingTail

        vsLabel.text = "VS"
        vsLabel.font = .boldSystemFont(ofSize: 18)
        vsLabel.textColor = .systemYellow

        let leftStack = UIStackView(arrangedSubviews: [radiantLogo, radiantName])
        leftStack.axis = .vertical
        leftStack.alignment = .center
        leftStack.spacing = 8

        let rightStack = UIStackView(arrangedSubviews: [direLogo, direName])
        rightStack.axis = .vertical
        rightStack.alignment = .center
        rightStack.spacing = 8

        middleStack.axis = .horizontal
        middleStack.alignment = .center
        middleStack.distribution = .equalSpacing
        middleStack.translatesAutoresizingMaskIntoConstraints = false

        middleStack.addArrangedSubview(leftStack)
        middleStack.addArrangedSubview(vsLabel)
        middleStack.addArrangedSubview(rightStack)

        cardView.addSubview(middleStack)

        NSLayoutConstraint.activate([
            middleStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            middleStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            middleStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24)
        ])

        // Divider
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

        clockIcon.image = UIImage(systemName: "clock.fill")
        clockIcon.tintColor = .systemYellow
        clockIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        clockIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true

        timeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        timeLabel.textColor = .lightGray

        bottomStack.axis = .horizontal
        bottomStack.spacing = 8
        bottomStack.alignment = .center
        bottomStack.translatesAutoresizingMaskIntoConstraints = false

        bottomStack.addArrangedSubview(clockIcon)
        bottomStack.addArrangedSubview(timeLabel)

        cardView.addSubview(bottomStack)

        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12),
            bottomStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            bottomStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }


    func configure(with model: MatchOverview) {

        leagueLabel.text = model.leagueName?.uppercased()
        groupBadge.text = "SOON"

        radiantName.text = model.radiantTeam
        direName.text = model.direTeam

        timeLabel.text = formattedDate(from: model.timeText)

        if let radiantLogoURL = model.radiantLogo,
           let url = URL(string: radiantLogoURL) {
            radiantLogo.kf.setImage(with: url)
        }

        if let direLogoURL = model.direLogo,
           let url = URL(string: direLogoURL) {
            direLogo.kf.setImage(with: url)
        }
    }


    private func formattedDate(from isoString: String) -> String {

        let formatter = ISO8601DateFormatter()

        guard let date = formatter.date(from: isoString) else {
            return isoString
        }

        let interval = Int(date.timeIntervalSinceNow)

        if interval <= 0 {
            return "Started"
        }

        let hours = interval / 3600
        let minutes = (interval % 3600) / 60

        return "Starts in \(hours)h \(minutes)m"
    }
}
