import UIKit
import Kingfisher
final class ProMatchesCell: UITableViewCell {
    
    static let proID = "ProMatchesID"
    
 
    private let cardView = UIView()
    
  
    private let leagueLabel = UILabel()
    private let dateLabel = UILabel()
    private let durationLabel = UILabel()
    
    private let radiantStateLabel = UILabel()
    private let radiantLogo = UIImageView()
    private let direStateLabel = UILabel()
    private let direLogo = UIImageView()
  
    private let radiantNameLabel = UILabel()
    private let direNameLabel = UILabel()
    
    private let radiantScoreLabel = UILabel()
    private let colonLabel = UILabel()
    private let direScoreLabel = UILabel()
    
    private let scoreStack = UIStackView()
    private let mainStack = UIStackView()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        
        cardView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        cardView.layer.cornerRadius = 18
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
       
        leagueLabel.font = .systemFont(ofSize: 18, weight: .bold)
        leagueLabel.textColor = UIColor(named: "colorWhite")
        leagueLabel.textAlignment = .center
        
        dateLabel.font = .systemFont(ofSize: 15, weight: .medium)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .center
        
        durationLabel.font = .systemFont(ofSize: 15)
        durationLabel.textColor = .lightGray
        durationLabel.textAlignment = .center
        
       
        radiantNameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        radiantNameLabel.textColor = UIColor(named: "colorWhite")
        radiantNameLabel.numberOfLines = 2
        radiantNameLabel.textAlignment = .left
        
        radiantStateLabel.text = "WIN"
        radiantStateLabel.font = .boldSystemFont(ofSize: 12)
        radiantStateLabel.textColor = .black
        radiantStateLabel.backgroundColor = .systemGreen
        radiantStateLabel.layer.cornerRadius = 6
        radiantStateLabel.clipsToBounds = true
        radiantStateLabel.textAlignment = .center
        radiantStateLabel.isHidden = true
        radiantStateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        radiantStateLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        direStateLabel.text = "WIN"
        direStateLabel.font = .boldSystemFont(ofSize: 12)
        direStateLabel.textColor = .black
        direStateLabel.backgroundColor = .systemGreen
        direStateLabel.layer.cornerRadius = 6
        direStateLabel.clipsToBounds = true
        direStateLabel.isHidden = true
        direStateLabel.textAlignment = .center
        direStateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        direStateLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
       
        radiantStateLabel.textAlignment = .center
        dateLabel.textAlignment = .center
        direStateLabel.textAlignment = .center
        
        radiantLogo.contentMode = .scaleAspectFit
        radiantLogo.widthAnchor.constraint(equalToConstant: 80).isActive = true
        radiantLogo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        direLogo.contentMode = .scaleAspectFit
        direLogo.widthAnchor.constraint(equalToConstant: 80).isActive = true
        direLogo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        direNameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        direNameLabel.textColor = UIColor(named: "colorWhite")
        direNameLabel.numberOfLines = 2
        direNameLabel.textAlignment = .right
        
        
        radiantScoreLabel.font = .boldSystemFont(ofSize: 20)
        radiantScoreLabel.textColor = UIColor(named: "colorWhite")
        radiantScoreLabel.textAlignment = .center
        direScoreLabel.font = .boldSystemFont(ofSize: 20)
        direScoreLabel.textColor = UIColor(named: "colorWhite")
        direScoreLabel.textAlignment = .center
        colonLabel.font = .boldSystemFont(ofSize: 20)
        colonLabel.text = ":"
        colonLabel.textAlignment = .center
        colonLabel.textColor = UIColor(named: "colorWhite")

        
        
        
        
        scoreStack.axis = .horizontal
        scoreStack.spacing = 10
        scoreStack.alignment = .center
        scoreStack.distribution = .fillEqually
        scoreStack.addArrangedSubview(radiantScoreLabel)
        scoreStack.addArrangedSubview(colonLabel)
        scoreStack.addArrangedSubview(direScoreLabel)
        
    
        mainStack.axis = .vertical
        mainStack.spacing = 4
        mainStack.alignment = .fill
        let stateRow = UIStackView()
        stateRow.axis = .horizontal
        stateRow.distribution = .fill
        stateRow.addArrangedSubview(radiantStateLabel)
        stateRow.addArrangedSubview(dateLabel)
        stateRow.addArrangedSubview(direStateLabel)
        let middleRow = UIStackView()
        middleRow.axis = .horizontal
        middleRow.spacing = 8
        middleRow.addArrangedSubview(radiantLogo)
        middleRow.addArrangedSubview(scoreStack)
        middleRow.addArrangedSubview(direLogo)
        
        
        let scoreRow = UIStackView()
        scoreRow.axis = .horizontal
        scoreRow.distribution = .fillEqually
        
        scoreRow.addArrangedSubview(radiantNameLabel)
        scoreRow.addArrangedSubview(durationLabel)
        scoreRow.addArrangedSubview(direNameLabel)
        
        mainStack.addArrangedSubview(leagueLabel)
        mainStack.addArrangedSubview(stateRow)
        mainStack.addArrangedSubview(middleRow)
        mainStack.addArrangedSubview(scoreRow)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layoutIfNeeded()
        
        cardView.layer.cornerRadius = 18
        cardView.applyGradientBorder(
                colors: [.red, .orange, .yellow],
                lineWidth: 1.5
            )
    }
    private func formatDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy • HH:mm"
        return formatter.string(from: date)
    }
    
    func configure(with model: ProMatchesModel, radiantLogoURL: String?, direLogoURL: String?) {

        leagueLabel.text = model.leagueName ?? "Unknown League"
        if let startTime = model.startTime {
            dateLabel.text = formatDate(startTime)
        } else {
            dateLabel.text = "-"
        }
       
        durationLabel.text = formatDuration(model.duration)
        
        radiantNameLabel.text = model.radiantName ?? "Radiant"
        direNameLabel.text = model.direName ?? "Dire"
        
        let radiantScore = model.radiantScore ?? 0
        let direScore = model.direScore ?? 0
        
        radiantScoreLabel.text = "\(radiantScore)"
        direScoreLabel.text = "\(direScore)"
        
        radiantStateLabel.isHidden = true
        direStateLabel.isHidden = true
        
        if let radiantWin = model.radiantWin {
            if radiantWin {
                radiantStateLabel.isHidden = false
                radiantScoreLabel.textColor = .systemGreen
                radiantNameLabel.textColor = .systemGreen
                direScoreLabel.textColor = UIColor(named: "colorWhite")
                direNameLabel.textColor = UIColor(named: "colorWhite")
            } else {
                direStateLabel.isHidden = false
                radiantScoreLabel.textColor = UIColor(named: "colorWhite")
                radiantNameLabel.textColor = UIColor(named: "colorWhite")
                direScoreLabel.textColor = .systemGreen
                direNameLabel.textColor = .systemGreen
            }
        }
        
        if let radiantLogoURL,
           let url = URL(string: radiantLogoURL) {
            
            radiantLogo.kf.setImage(with: url,
                                    placeholder: UIImage(named: "placeholder"))
        } else {
            radiantLogo.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
            radiantLogo.tintColor = UIColor(named: "colorGray")
            radiantLogo.widthAnchor.constraint(equalToConstant: 60).isActive = true
            radiantLogo.heightAnchor.constraint(equalTo: radiantLogo.widthAnchor).isActive = true
        }

        if let direLogoURL,
           let url = URL(string: direLogoURL) {
            
            direLogo.kf.setImage(with: url,
                                 placeholder: UIImage(named: "placeholder"))
        } else {
            direLogo.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
            direLogo.tintColor = UIColor(named: "colorGray")
            direLogo.widthAnchor.constraint(equalToConstant: 60).isActive = true
            direLogo.heightAnchor.constraint(equalTo: direLogo.widthAnchor).isActive = true
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        radiantLogo.kf.cancelDownloadTask()
        direLogo.kf.cancelDownloadTask()
        radiantLogo.image = nil
        direLogo.image = nil
    }
    
    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let sec = seconds % 60
        return String(format: "%02d:%02d", minutes, sec)
    }
}
