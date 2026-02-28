//
//  LiveMatch.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 25/02/26.
//

struct MatchOverview: Hashable {
    let id: Int
    
    let leagueName: String?
    let leagueLogo: String?
    
    let radiantTeam: String
    let radiantLogo: String?
    
    let direTeam: String
    let direLogo: String?
    
    let scoreText: String?
    let statusText: String
    let timeText: String
    
}
