//
//  HeroesModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 26/02/26.
//

import Foundation
struct Hero: Hashable {
    let id: Int
    let apiName: String 
    let name: String
    let attribute: String
    let attackType: String
    let roles: [String]
    let image: String
    let icon: String

    
    let health: Int
    let mana: Int
    let armor: Double?
    let speed: Int
       
       
    let strength: Int
    let agility: Int
    let intelligence: Int
    let strGain: Double
    let agiGain: Double
    let intGain: Double
    let baseAttackMin: Int
    let baseAttackMax: Int
    let attackRange: Int
    let attackRate: Double
    let baseMr: Int?
    let dayVision: Int
    let nightVision: Int

    let turboPicks: Int
    let turboWins: Int

    let proPick: Int
    let proWin: Int

    let pubPick: Int
    let pubWin: Int
    
    var totalHP: Int {
        health + (strength * 20)
    }
    var totalMana: Int {
        mana + (intelligence * 12)
    }
    
    var fullImageURL: URL? {
        let cleaned = image.replacingOccurrences(of: "?", with: "")
        return URL(string: "https://cdn.cloudflare.steamstatic.com\(cleaned)")
    }
    
    var lore: String {
        HeroLoreProvider.shared.lore(for: apiName)
    }
    
    var turboWinrate: Double {
        guard turboPicks > 0 else { return 0 }
        return Double(turboWins) / Double(turboPicks) * 100
    }

    var proWinrate: Double {
        guard proPick > 0 else { return 0 }
        return Double(proWin) / Double(proPick) * 100
    }

    var pubWinrate: Double {
        guard pubPick > 0 else { return 0 }
        return Double(pubWin) / Double(pubPick) * 100
    }
}
