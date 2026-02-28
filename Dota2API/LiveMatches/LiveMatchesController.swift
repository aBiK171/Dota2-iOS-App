//
//  LiveMatchesController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 25/02/26.
//

import UIKit

final class LiveMatchesController: UIViewController {
    
    private let backgroundView = BackgroundView(imageName: "imageBgFive", overlayAlpha: 0.6)
    private let customNav = CustomNavBarView()
    private let viewModel: LiveMatchesViewModel
    
    enum LiveMatchesSection: Int, CaseIterable {
        case upcoming
        case live
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<LiveMatchesSection, MatchOverview>!
    
    init(viewModel: LiveMatchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setupBackground()
        self.setupCustomNav()
        self.setupCollectionView()
        self.configureDataSource()
        self.applySnapshot()

           Task {
               await viewModel.fetchUpcoming()
               await viewModel.fetchRunning()
               applySnapshot()    
           }
        
       
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
        customNav.configure(center: .title("Live Matches"), leftImage: UIImage(named: "buttonMenu")?.withRenderingMode(.alwaysTemplate), rightImage: UIImage(named: "buttonNotif")?.withRenderingMode(.alwaysTemplate))
        customNav.onLeftTap = { [weak self] in
            self?.openMenu()
        }
    }
    
    private func configureDataSource() {

        dataSource = UICollectionViewDiffableDataSource<LiveMatchesSection, MatchOverview>(
            collectionView: collectionView
        ) { collectionView, indexPath, match in
            
            switch LiveMatchesSection.allCases[indexPath.section] {
                
            case .upcoming:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: UpcomingCell.identifier,
                    for: indexPath
                ) as! UpcomingCell

                cell.configure(with: match)
                
                return cell
                
            case .live:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LiveCell.identifier,
                    for: indexPath
                ) as! LiveCell

                cell.configure(with: match)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath
            ) as! SectionHeaderView
            
            let section = LiveMatchesSection(rawValue: indexPath.section)
            
            switch section {
            case .upcoming:
                header.configure(title: "Upcoming Matches:")
            case .live:
                header.configure(title: "Live Matches:")
            case .none:
                break
            }
            
            return header
        }
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: customNav.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(UpcomingCell.self,
                                forCellWithReuseIdentifier: UpcomingCell.identifier)
        
        collectionView.register(LiveCell.self,
                                forCellWithReuseIdentifier: LiveCell.identifier)
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            guard let section = LiveMatchesSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
                
            case .upcoming:
                return self.createUpcomingSection()
                
            case .live:
                return self.createLiveSection()
            }
        }
    }
    
    private func createLiveSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(260)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: itemSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 20,
            trailing: 16
        )
        
        section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }
    
    private func createUpcomingSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .absolute(220)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 50,
            trailing: 16
        )
        
        section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
        )
        
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
    
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<LiveMatchesSection, MatchOverview>()
        
        snapshot.appendSections([.upcoming, .live])
        
        snapshot.appendItems(viewModel.upcoming, toSection: .upcoming)
        snapshot.appendItems(viewModel.running, toSection: .live)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func openMenu() {
        (navigationController?.parent as? ContainerViewController)?.toggleMenu()
    }
}
