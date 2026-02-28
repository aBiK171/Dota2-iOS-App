//
//  ProPlayersController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 24/02/26.
//

import UIKit

class ProPlayersController: UIViewController {
    
    private let backgroundView = BackgroundView(imageName: "imageBgFour", overlayAlpha: 0.6)
    private let customNav = CustomNavBarView()
    private var collectionView : UICollectionView!
    private let players = LocalProPlayer.mockData
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setupBackground()
        self.setupCustomNav()
        self.initPlayersCollect()
        
    }
    private func setupBackground() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(backgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    private func setupCustomNav() {
        customNav.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        customNav.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customNav)
        
        NSLayoutConstraint.activate([
            customNav.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            customNav.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            customNav.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            customNav.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
        ])
        customNav.configure(center: .title("Pro Players"), leftImage: UIImage(named: "buttonMenu")?.withRenderingMode(.alwaysTemplate), rightImage: UIImage(named: "buttonNotif")?.withRenderingMode(.alwaysTemplate))
        customNav.onLeftTap = { [weak self] in
            self?.openMenu()
        }
    }

    
    
    private func initPlayersCollect() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let spacing: CGFloat = 10
        let totalSpacing = padding * 2 + spacing
        let width = (view.frame.width - totalSpacing) / 2

        layout.itemSize = CGSize(width: width, height: 300)
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ProPlayersCell.self, forCellWithReuseIdentifier: ProPlayersCell.proPlayerId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.customNav.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    @objc private func openMenu() {
        (navigationController?.parent as? ContainerViewController)?.toggleMenu()
    }
}

extension ProPlayersController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProPlayersCell.proPlayerId,
            for: indexPath
        ) as! ProPlayersCell

        let player = players[indexPath.row]
        cell.configure(with: player)

        return cell
    }
}
