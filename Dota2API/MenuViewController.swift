//
//  MenuViewController.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//
import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func menuDidSelect(_ destination: MenuDestination)
}

final class MenuViewController: UIViewController {
    
    private let tableView = UITableView()
    private let avatar = UIImageView()
    weak var delegate: MenuViewControllerDelegate?
    
    private var items: [MenuItem] = [
        MenuItem(title: "Home", icon: "buttonHome", destination: .home),
        MenuItem(title: "My Profile", icon: "buttonProfile", destination: .myProfile),
        
        MenuItem(title: "Pro Matches", icon: "buttonProMatch", destination: .proMatches),
        MenuItem(title: "Pro Players", icon: "buttonProPlayer", destination: .proPlayers),
        MenuItem(title: "Live Matches", icon: "buttonLive", destination: .liveMatches),
        MenuItem(title: "Heroes", icon: "buttonProPlayer", destination: .heroes),
        MenuItem(title: "Settings", icon: "gear", destination: .settings),
        MenuItem(title: "Support", icon: "questionmark.circle", destination: .support)
    ]
    
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeader()
        self.setupUI()
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "colorRed")
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.identifier)
        tableView.rowHeight = 64
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.avatar.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
      
    }
    
    private func setupHeader() {
        
        avatar.image = UIImage(named: "buttonUser")
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = "Unknown user"
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(avatar)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatar.widthAnchor.constraint(equalToConstant: 50),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        ])
    }
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        let item = items[indexPath.row]
        cell.configure(with: item, isActive: indexPath.row == self.selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        tableView.reloadData()
        
        let item = items[indexPath.row]
        delegate?.menuDidSelect(item.destination)
    }
    
    
}
