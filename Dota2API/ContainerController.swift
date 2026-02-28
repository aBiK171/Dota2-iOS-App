//
//  ContainerController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

final class ContainerViewController: UIViewController {

    private let menuVC = MenuViewController()
    private var isMenuOpen = false
    private var menuWidth: CGFloat {
        view.bounds.width * 0.8
    }
    
    private let pandaService: PandaScoreProtocol
    private let openDotaService: OpenDotaProtocol
    private let contentNavController: UINavigationController
    
    
    init(
        rootViewController: UIViewController,
        pandaService: PandaScoreProtocol,
        openDotaService: OpenDotaProtocol
    ) {
        self.contentNavController = UINavigationController(rootViewController: rootViewController)
        self.pandaService = pandaService
        self.openDotaService = openDotaService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        menuVC.delegate = self
        // Menu
        addChild(menuVC)
        menuVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            menuVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuVC.view.widthAnchor.constraint(equalToConstant: menuWidth)
        ])
        
        // Content
        addChild(contentNavController)
        contentNavController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentNavController.view)
        contentNavController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            contentNavController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentNavController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentNavController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentNavController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func toggleMenu() {
        isMenuOpen.toggle()
        
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0.8) {
            
            self.contentNavController.view.transform =
                self.isMenuOpen ? CGAffineTransform(translationX: self.menuWidth, y: 0)
                : .identity
        }
    }
}


extension ContainerViewController: MenuViewControllerDelegate {

    func menuDidSelect(_ destination: MenuDestination) {

        let vc: UIViewController

        switch destination {
            
        case .home:
            vc = HomeController(viewModel: HomeViewModel(pandaService: pandaService, openDotaService: openDotaService))
            
        case .myProfile:
            vc = MyProfileController()

        case .proMatches:
            vc = ProMatchesController()

        case .proPlayers:
            vc = ProPlayersController()

        case .liveMatches:
            vc = LiveMatchesController(viewModel: LiveMatchesViewModel(pandaService: pandaService))

        case .heroes:
            vc = HeroesController(viewModel: HeroesViewModel(openService: openDotaService))

        case .settings:
            vc = ProMatchesController()

        case .support:
            vc = ProMatchesController()
        }

 
        toggleMenu()

      
        contentNavController.pushViewController(vc, animated: true)
    }
}
