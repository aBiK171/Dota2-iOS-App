//
//  AppDelegate.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initWindow()
        return true
    }

    func initWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let networkService = NetworkService()
        let pandaService = PandaScoreService(networkService: networkService)
        let openDotaService = OpenDotaService(networkService: networkService)
        let viewModel = HomeViewModel(pandaService: pandaService, openDotaService: openDotaService)
        
        let root = HomeController(viewModel: viewModel)
        let container = ContainerViewController(
            rootViewController: root,
            pandaService: pandaService,
            openDotaService: openDotaService
        )
        window?.rootViewController = container
        window?.makeKeyAndVisible()
    }
   

}

