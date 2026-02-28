//
//  HomeController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//

import UIKit

class HomeController: UIViewController {
    
    private let backgroundView = BackgroundView(imageName: "imageBgFive", overlayAlpha: 0.6)
    private let customNav = CustomNavBarView()
    private let viewModel: HomeViewModel
    private var dataSource: UICollectionViewDiffableDataSource<HomeViewModel.HomeSectionType, HomeViewModel.HomeItem>!
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var collectionView: UICollectionView = {
            let layout = createLayout()
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .clear
            cv.translatesAutoresizingMaskIntoConstraints = false
            return cv
        }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        setupBackground()
        setupCustomNav()
        setupUI()
        configureDataSource()
        load()
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
        customNav.configure(center: .button(UIImage(named: "buttonLogo")), leftImage: UIImage(named: "buttonMenu")?.withRenderingMode(.alwaysTemplate), rightImage: UIImage(named: "buttonNotif")?.withRenderingMode(.alwaysTemplate))
        customNav.onLeftTap = { [weak self] in
            self?.openMenu()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.customNav.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        collectionView.register(
            HomeSectionsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionsHeaderView.reuseId
        )
        
        collectionView.register(
            HomeLiveCell.self,
            forCellWithReuseIdentifier: HomeLiveCell.reuseId
        )

        collectionView.register(
            HomeUpcomingCell.self,
            forCellWithReuseIdentifier: HomeUpcomingCell.reuseId
        )
        
        collectionView.register(
            HeroHomeCell.self,
            forCellWithReuseIdentifier: HeroHomeCell.reuseId
        )
        
        collectionView.register(
            HomeProMatchCell.self,
            forCellWithReuseIdentifier: HomeProMatchCell.reuseId
        )
        
        
    }
    
    private func title(for section: HomeViewModel.HomeSectionType) -> String {
        switch section {
        case .live: return "Live Matches"
        case .upcoming: return "Upcoming Matches"
        case .heroes: return "Top Heroes"
        case .finished: return "Finished Matches"
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {

        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            
            guard let self = self else { return nil }
            
            let type = self.viewModel.sections[sectionIndex].type
            
            switch type {
            case .upcoming, .heroes, .live, .finished:
                return Self.createHorizontalSection(height: 200)
            default:
                return nil
            }
        }
    }
    
    
    
    
    
    
    
    private static func createHorizontalSection(height: CGFloat) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .absolute(height)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 16)
        
        // Header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    private func load() {
        Task {
            try await viewModel.load()
            
            await MainActor.run {
                self.applySnapshot()
            }
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeViewModel.HomeSectionType, HomeViewModel.HomeItem>()

        for section in viewModel.sections {
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.items, toSection: section.type)
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func mapSection(_ type: HomeViewModel.HomeSectionType) -> HomeViewModel.HomeSectionType {
        switch type {
        case .live: return .live
        case .upcoming: return .upcoming
        case .heroes: return .heroes
        case .finished: return .finished
        }
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<HomeViewModel.HomeSectionType, HomeViewModel.HomeItem>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in

            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]

            switch (section, item) {

            case (.live, .match(let match)):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeLiveCell.reuseId,
                    for: indexPath
                ) as! HomeLiveCell
                cell.configure(with: match)
                return cell

            case (.upcoming, .match(let match)):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeUpcomingCell.reuseId,
                    for: indexPath
                ) as! HomeUpcomingCell
                cell.configure(with: match)
                return cell

            case (.heroes, .hero(let hero)):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HeroHomeCell.reuseId,
                    for: indexPath
                ) as! HeroHomeCell
                cell.configure(with: hero)
                return cell

            case (.finished, .match(let match)):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeProMatchCell.reuseId,
                    for: indexPath
                ) as! HomeProMatchCell
                cell.configure(with: match)
                return cell

            default:
                fatalError("Wrong section-item combination")
            }
        }
        

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView? in
            
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let self else { return nil }

            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionsHeaderView.reuseId,
                for: indexPath
            ) as! HomeSectionsHeaderView

            let sectionType = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            header.configure(title: self.title(for: sectionType))

            return header
        }
    }

    
    
    
    
    
    
    @objc private func openMenu() {
        (navigationController?.parent as? ContainerViewController)?.toggleMenu()
    }
}
