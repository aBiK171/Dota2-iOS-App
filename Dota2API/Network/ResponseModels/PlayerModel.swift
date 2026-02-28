//
//  PlayerModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//
import Foundation
struct PlayerResponse: Codable {
    let profile: Profile?
    let rankTier: Int?
    let computedMmr: Double?
}

struct Profile: Codable {
    let accountId: Int?
    let personaname: String?
    let plus: Bool?
    let steamid: String?
    let avatar: String?
    let avatarmedium: String?
    let avatarfull: String?
    let profileurl: String?
    let lastLogin: String?
    let loccountrycode: String?
}
struct WinLoseResponse: Codable {
    let win: Int
    let lose: Int
}
