//
//  StatBarView.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//
import UIKit

final class StatBarView: UIView {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let fillView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        layer.cornerRadius = 8
        clipsToBounds = true

        fillView.layer.cornerRadius = 8
        addSubview(fillView)

        valueLabel.font = .systemFont(ofSize: 13, weight: .bold)
        valueLabel.textColor = UIColor(named: "colorWhite")
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        fillView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: fillView.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: fillView.centerYAnchor)
        ])
       

        fillView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillView.topAnchor.constraint(equalTo: topAnchor),
            fillView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fillView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fillView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }

    func configure(value: String, color: UIColor) {
        valueLabel.text = value
        fillView.backgroundColor = color
        
    }
}
