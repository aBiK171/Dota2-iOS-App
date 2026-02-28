import UIKit
import Kingfisher

final class HeroHomeCell: UICollectionViewCell {

    static let reuseId = "HeroHomeCell"

    private let imageView = UIImageView()
    private let gradientLayer = CAGradientLayer()

    private let nameLabel = UILabel()
    private let wrLabel = UILabel()
    private let playLabel = UILabel()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }

    private func setupUI() {

        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true
        contentView.backgroundColor = .black

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        gradientLayer.locations = [0.5, 1.0]
        contentView.layer.addSublayer(gradientLayer)

        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        wrLabel.font = .boldSystemFont(ofSize: 16)
        wrLabel.textColor = .systemYellow
        wrLabel.textAlignment = .right
        wrLabel.translatesAutoresizingMaskIntoConstraints = false

        playLabel.font = .systemFont(ofSize: 13, weight: .medium)
        playLabel.textColor = .lightGray
        playLabel.textAlignment = .right
        playLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(playLabel)
        contentView.addSubview(wrLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            playLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            playLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            wrLabel.trailingAnchor.constraint(equalTo: playLabel.trailingAnchor),
            wrLabel.bottomAnchor.constraint(equalTo: playLabel.bottomAnchor, constant: -24)
        ])

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 6)
    }

    func configure(with hero: Hero) {

        nameLabel.text = hero.name

        let winRate = hero.pubPick > 0
            ? Double(hero.pubWin) / Double(hero.pubPick) * 100
            : 0

        let playPercent = hero.pubPick

        wrLabel.text = String(format: "%.1f%% WR", winRate)
        playLabel.text = "\(playPercent) Play"

        if let url = hero.fullImageURL {
            imageView.kf.setImage(with: url)
        }
    }
}
