import UIKit

final class HeroStatView: UIView {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .systemGray3
        
        valueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textColor = .white
        
        let stack = UIStackView(arrangedSubviews: [
            iconImageView,
            titleLabel,
            valueLabel
        ])
        
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(icon: UIImage?, title: String, value: String) {
        iconImageView.image = icon
        titleLabel.text = title
        valueLabel.text = value
    }
}
