//
//  MenuModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

struct MenuItem {
    let title: String
    let icon: String
    let destination: MenuDestination
}
enum MenuDestination {
    case home
    case myProfile
    case proMatches
    case proPlayers
    case liveMatches
    case heroes
    case settings
    case support
}
