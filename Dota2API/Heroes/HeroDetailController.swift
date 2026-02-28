//
//  HeroDetailController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 26/02/26.
//

import UIKit

final class HeroDetailController: UIViewController {
    private let hero: Hero
//    private let backgroundView = BackgroundView(imageName: "imageBgFive")
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let buttonClose = UIButton()
    private let headerView = HeroHeaderView()
    private let winrateView = WinrateSectionView()

    private let statsView = HeroStatGridView()
    
    init(hero: Hero){
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setupBackground()
        self.setupLayout()
        self.setupCloseButton()
        self.configure()
    }
    
//    private func setupBackground() {
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.insertSubview(backgroundView, at: 0)
//        
//        NSLayoutConstraint.activate([
//            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
//        
//    }
    
    private func setupCloseButton() {
        buttonClose.setImage(UIImage(named: "buttonClose")?.withRenderingMode(.alwaysTemplate), for: .normal)
        buttonClose.addTarget(self, action: #selector(onClose(_ :)), for: .touchUpInside)
        buttonClose.tintColor = UIColor(named: "colorWhite")
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonClose)
        
        NSLayoutConstraint.activate([
            buttonClose.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            buttonClose.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            buttonClose.widthAnchor.constraint(equalToConstant: 20),
            buttonClose.heightAnchor.constraint(equalTo: self.buttonClose.widthAnchor)
            
        ])
    }
    
    private func setupLayout() {
        view.backgroundColor = .black
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let stack = UIStackView(arrangedSubviews: [
            headerView,
            winrateView,
            statsView
        ])
        
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    
    
    
    private func configure() {
        headerView.configure(with: hero)
        winrateView.configure(with: hero)
        statsView.configure(with: hero)
    }
    
    @objc func onClose(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
