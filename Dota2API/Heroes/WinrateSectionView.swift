import UIKit

final class WinrateSectionView: UIView {
    
    private let stackView = UIStackView()
    
    private let turboCard = WinrateCardView()
    private let proCard = WinrateCardView()
    private let pubCard = WinrateCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(turboCard)
        stackView.addArrangedSubview(proCard)
        stackView.addArrangedSubview(pubCard)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(with hero: Hero) {
        
        turboCard.configure(
            title: "Turbo",
            winrate: hero.turboWinrate,
            picks: hero.turboPicks,
            colors: [.systemOrange, .systemRed]
        )
        
        proCard.configure(
            title: "Pro",
            winrate: hero.proWinrate,
            picks: hero.proPick,
            colors: [.systemPurple, .systemIndigo]
        )
        
        pubCard.configure(
            title: "Pub",
            winrate: hero.pubWinrate,
            picks: hero.pubPick,
            colors: [.systemGreen, .systemTeal]
        )
    }
}


