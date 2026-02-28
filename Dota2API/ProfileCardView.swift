import UIKit
final class ProfileCardView: UIView {

    private let imageAvatar = UIImageView()
    private let labelName = UILabel()
    private let labelId = UILabel()
    private let stat1 = ProfileStatView()
    private let stat2 = ProfileStatView()
    private let stat3 = ProfileStatView()

    private let statsStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false

        // Avatar
        imageAvatar.translatesAutoresizingMaskIntoConstraints = false
        imageAvatar.layer.cornerRadius = 10
        imageAvatar.clipsToBounds = true
        addSubview(imageAvatar)

        // Labels
        labelName.textColor = .white
        labelName.font = .boldSystemFont(ofSize: 20)

        labelId.textColor = .lightGray
        labelId.font = .systemFont(ofSize: 14)

        let nameStack = UIStackView(arrangedSubviews: [labelName, labelId])
        nameStack.axis = .vertical
        nameStack.spacing = 4
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameStack)

        // Stats stack
        statsStack.axis = .horizontal
        statsStack.spacing = 12
        statsStack.distribution = .fillEqually
        statsStack.translatesAutoresizingMaskIntoConstraints = false

        statsStack.addArrangedSubview(stat1)
        statsStack.addArrangedSubview(stat2)
        statsStack.addArrangedSubview(stat3)

        addSubview(statsStack)

        NSLayoutConstraint.activate([
            imageAvatar.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageAvatar.widthAnchor.constraint(equalToConstant: 60),
            imageAvatar.heightAnchor.constraint(equalTo: imageAvatar.widthAnchor),

            nameStack.centerYAnchor.constraint(equalTo: imageAvatar.centerYAnchor),
            nameStack.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 16),
            nameStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            statsStack.topAnchor.constraint(equalTo: imageAvatar.bottomAnchor, constant: 20),
            statsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            statsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            statsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            statsStack.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    func updateWinrate(_ value: Double) {
        stat3.configure(
            value: "\(Int(value))%",
            title: "Winrate"
        )
    }
    
    func formattedDate(from isoString: String?) -> String {
        guard let isoString else { return "-" }

        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = iso.date(from: isoString) else { return "-" }

        let output = DateFormatter()
        output.dateFormat = "dd MMM yyyy"
        output.locale = Locale(identifier: "en_US_POSIX") // 👈 MUHIM

        return output.string(from: date)
    }
    
    func configure(with model: PlayerResponse) {

        labelName.text = model.profile?.personaname ?? "Unknown"
        labelId.text = "ID: \(model.profile?.accountId ?? 0)"

        if let urlString = model.profile?.avatarfull,
           let url = URL(string: urlString) {
            // oddiy loading
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageAvatar.image = image
                    }
                }
            }
        }
        let lastLoginText = formattedDate(from: model.profile?.lastLogin)
        stat1.configure(
            value: "\(lastLoginText)",
            title: "Last online"
        )
       
        stat2.configure(
            value: "\(model.profile?.loccountrycode ?? "Unknown")",
            title: "Country"
        )
        print(model.profile?.plus ?? "No plus")

        
      
    }
}
