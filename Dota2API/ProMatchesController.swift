//
//  ProMatchesController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 23/02/26.
//

import UIKit

final class ProMatchesController: UIViewController {
    
    var proMatches: [ProMatchesModel] = []
    private let backgroundView = BackgroundView(imageName: "imageBgSec", overlayAlpha: 0.8)
    private let customNav = CustomNavBarView()
    private let networkService = OpenDotaService(networkService: NetworkService())
    var teamCache: [Int: TeamModel] = [:]
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        self.setupBg()
        self.setupCustomNav()
        self.loadProMatches()
        self.initTable()
        
    }
    
    private func setupBg() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
           ])
    }
    
    private func setupCustomNav() {
        customNav.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        customNav.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customNav)
        
        NSLayoutConstraint.activate([
            customNav.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            customNav.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            customNav.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            customNav.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
        ])
        customNav.configure(
            center: .title("Pro matches"),
            leftImage: UIImage(named: "buttonMenu")?.withRenderingMode(.alwaysTemplate),
            rightImage: UIImage(named: "buttonNotif")?.withRenderingMode(.alwaysTemplate)
        )
        customNav.onLeftTap = { [weak self] in
            self?.openMenu()
        }
    }
    
    
    private func loadProMatches() {
        Task {
            do {
                let matches = try await networkService.getProMatches()
                self.proMatches = Array(matches.prefix(40))
                
                let teams = try await networkService.getAllTeams()
                for team in teams {
                    if let id = team.teamId {
                        teamCache[id] = team
                    }
                }
                
                self.tableView.reloadData()
                
            } catch {
                print(error)
            }
        }
    }
    
    private func loadTeams(from matches: [ProMatchesModel]) async {
        
        let ids = matches.flatMap { [$0.radiantTeamId, $0.direTeamId] }
            .compactMap { $0 }
        
        let uniqueIDs = Set(ids)
        
        for id in uniqueIDs {
            do {
                let team = try await networkService.getTeam(id: id)
                teamCache[id] = team
                print("TEAM:", team.teamId ?? 0, team.logoUrl ?? "NO LOGO")
            } catch {
                print("Team fetch error:", error)
            }
        }
        
    }
    
    private func initTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tableView.layer.cornerRadius = 10
        tableView.register(ProMatchesCell.self, forCellReuseIdentifier: ProMatchesCell.proID)
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.customNav.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    @objc private func openMenu() {
        (navigationController?.parent as? ContainerViewController)?.toggleMenu()
    }
}

extension ProMatchesController: UITableViewDataSource, UITableViewDelegate  {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.proMatches.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProMatchesCell.proID, for: indexPath) as! ProMatchesCell
        let match = proMatches[indexPath.section]

        let radiantLogoURL = teamCache[match.radiantTeamId ?? 0]?.logoUrl
        let direLogoURL = teamCache[match.direTeamId ?? 0]?.logoUrl

        cell.configure(with: match, radiantLogoURL: radiantLogoURL, direLogoURL: direLogoURL)
        print(radiantLogoURL ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
