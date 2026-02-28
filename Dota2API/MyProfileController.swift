//
//  ViewController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

class MyProfileController: UIViewController {
    
    private let backgroundView = BackgroundView(imageName: "imageBg", overlayAlpha: 0.55)
    private let customNav = CustomNavBarView()
    let networkService = OpenDotaService(networkService: NetworkService())
    private let profileCard = ProfileCardView()
    private var recentMatches: [RecentMatchesModel] = []
    private var heroesMap: [Int: HeroesResponse] = [:]
    private let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.initBackground()
        self.initCustomNav()
        self.initProfileCard()
        self.loadProfile()
        self.loadWinrate()
        self.loadHeroes()
        self.loadRecentMatches()
        self.initLastMatches()
        
        
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (parent as? ContainerViewController)?.toggleMenu()
    }
    
   
    
    private func initCustomNav() {
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
            center: .title("My Profile"),
            leftImage: UIImage(named: "buttonMenu")?.withRenderingMode(.alwaysTemplate),
            rightImage: UIImage(named: "buttonNotif")?.withRenderingMode(.alwaysTemplate)
        )
        customNav.onLeftTap = { [weak self] in
            self?.openMenu()
        }
    }
    
    private func initBackground() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
           ])
    }
    

    private func loadProfile() {
        Task {
            do {
                let response = try await networkService.getPlayers(id: 931081904)
                profileCard.configure(with: response)
            } catch {
                print(error)
            }
        }
    }
    
    private func initProfileCard() {
        profileCard.layer.cornerRadius = 20
        profileCard.layer.borderWidth = 1
        profileCard.layer.borderColor = UIColor.white.cgColor
        profileCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileCard)

        NSLayoutConstraint.activate([
            profileCard.topAnchor.constraint(equalTo: customNav.bottomAnchor, constant: 20),
            profileCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func loadWinrate() {
        Task {
            do {
                let wl = try await networkService.getWinrate(id: 931081904)

                let total = wl.win + wl.lose
                let winrate = total > 0 ? (Double(wl.win) / Double(total)) * 100 : 0

                profileCard.updateWinrate(winrate)
            
            } catch {
                print(error)
            }
        }
    }
    
    private func loadHeroes() {
        Task {
            do {
                let heroes = try await networkService.getHeroes()

                self.heroesMap = Dictionary(uniqueKeysWithValues:
                    heroes.map { ($0.id, $0) }
                )

            } catch {
                print(error)
            }
        }
    }
    
    private func loadRecentMatches() {
        Task {
            do {
                let matches = try await networkService.getRecentMatches(id: 931081904)

                self.recentMatches = matches
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch {
                print(error)
            }
        }
    }
    
    private func initLastMatches() {
        let labelLastMatches = UILabel()
        labelLastMatches.text = "Last 20 matches:"
        labelLastMatches.textColor = UIColor(named: "colorWhite")
        labelLastMatches.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        labelLastMatches.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelLastMatches)
        
        
        tableView.layer.cornerRadius = 20
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.layer.borderWidth = 0.2
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.register(LastMatchesCell.self, forCellReuseIdentifier: LastMatchesCell.lastMatchId)
        tableView.separatorColor = UIColor(named: "colorWhite")
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            labelLastMatches.topAnchor.constraint(equalTo: profileCard.bottomAnchor, constant: 20),
            labelLastMatches.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: labelLastMatches.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
    }
    
    @objc private func openMenu() {
        (navigationController?.parent as? ContainerViewController)?.toggleMenu()
    }
    
    
    
}

extension MyProfileController: UITableViewDataSource, UITableViewDelegate {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.recentMatches.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LastMatchesCell.lastMatchId, for: indexPath) as! LastMatchesCell
        let match = recentMatches[indexPath.row]
        let hero = heroesMap[match.heroId]
        
        let kda = Float(match.kills + match.assists) / max(Float(match.deaths), 1.0)
        let normalized = min(kda / 20.0, 1.0)
        cell.configure(
            heroName: hero?.localizedName ?? "Unknown",
            subtitle: "Match: \(match.matchId)",
            kills: match.kills, progress: normalized,
            deaths: match.deaths,
            assists: match.assists,
            image: nil
        )

        if let url = hero?.heroImageURL {
            cell.setImage(url)
        }
        
        return cell
    }
}

extension HeroesResponse {
    var heroImageURL: URL? {
        let cleanName = name
            .replacingOccurrences(of: "npc_dota_hero_", with: "")

        return URL(string:
        "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/\(cleanName).png")
    }
}
