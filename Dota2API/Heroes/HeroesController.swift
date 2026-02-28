//
//  HeroesController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 26/02/26.
//

import UIKit

final class HeroesController: UIViewController {
    
    private let customNav = CustomNavBarView()
    private let backgroundView = BackgroundView(imageName: "imageBgHeroes", overlayAlpha: 0.6)
    private let viewModel: HeroesViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Hero>!
    
    private let collectionView: UICollectionView = {
        let layout = HeroesController.createLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let attributeSegment = AttributeSegmentView()

  
    

       enum Section {
           case main
       }
    init(viewModel: HeroesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackground()
        self.setupCustomNav()
        self.setupUI()
        self.configureDataSource()
        self.loadData()
        
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
        customNav.configure(center: .title("Heroes list"), leftImage: UIImage(named: "buttonMenu")?.withRenderingMode(.alwaysTemplate), rightImage: UIImage(named: "buttonNotif")?.withRenderingMode(.alwaysTemplate))
        customNav.onLeftTap = { [weak self] in
            self?.openMenu()
        }
    }
    
    private func loadData() {
        Task {
            try await viewModel.fetchHeroes()
            applySnapshot()
        }
    }
    
    private func setupUI() {
        collectionView.backgroundColor = .clear
        collectionView.register(HeroCell.self, forCellWithReuseIdentifier: HeroCell.heroID)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        
        attributeSegment.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(attributeSegment)
        attributeSegment.onSelect = { [weak self] index in
            switch index {
            case 0: self?.viewModel.filter(by: "all")
            case 1: self?.viewModel.filter(by: "str")
            case 2: self?.viewModel.filter(by: "agi")
            case 3: self?.viewModel.filter(by: "int")
            default: break
            }
            self?.applySnapshot()
        }
        
        NSLayoutConstraint.activate([
            attributeSegment.topAnchor.constraint(equalTo: customNav.bottomAnchor, constant: 8),
            attributeSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            attributeSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: attributeSegment.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Hero>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.filteredHeroes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private static func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(125)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Hero>(
            collectionView: collectionView
        ) { collectionView, indexPath, hero in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HeroCell.heroID,
                for: indexPath
            ) as? HeroCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: hero)
            return cell
        }
    }
    
    
    
    
    
    
    
    
    
    @objc private func openMenu() {
        (navigationController?.parent as? ContainerViewController)?.toggleMenu()
    }
}


extension HeroesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hero = dataSource.itemIdentifier(for: indexPath) else { return }
        let dertailVC = HeroDetailController(hero: hero)
        present(dertailVC, animated: true)
        
    }
}
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
