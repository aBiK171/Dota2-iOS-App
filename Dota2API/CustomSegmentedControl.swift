//
//  CustomSegmentedControl.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//

import UIKit

final class AttributeSegmentView: UIView {
    
    var onSelect: ((Int) -> Void)?
    
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    private let icons = [
        "icon_all",
        "icon_str",
        "icon_agi",
        "icon_int"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 32)
        ])
        
        for (index, iconName) in icons.enumerated() {
            let button = UIButton()
            button.tag = index
            
            button.setImage(UIImage(named: iconName), for: .normal)
            button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            button.layer.cornerRadius = 12
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            buttons.append(button)
            stack.addArrangedSubview(button)
            
            if index == 0 {
                button.setImage(UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = UIColor(named: "colorWhite")
            }
            
        }
        
        updateSelection(animated: false)
    }
    
    @objc private func didTap(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateSelection(animated: true)
        onSelect?(selectedIndex)
    }

    private func updateSelection(animated: Bool) {
        
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                
                if animated {
                    UIView.animate(withDuration: 0.2) {
                        button.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
                    }
                }
            } else {
                button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
                button.transform = .identity
            }
        }
    }
}
