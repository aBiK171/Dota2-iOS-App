//
//  RecentMatchesModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

struct RecentMatchesModel: Codable {
    let matchId: Int
    let playerSlot: Int
    let radiantWin: Bool
    let heroId: Int
    let startTime: Int
    let duration: Int
    let gameMode: Int
    let lobbyType: Int
    let version: Int?
    let kills: Int
    let deaths: Int
    let assists: Int
    let averageRank: Int?
    let xpPerMin: Int
    let goldPerMin: Int
    let heroDamage: Int
    let towerDamage: Int
    let heroHealing: Int
    let lastHits: Int
    let lane: Int?
    let laneRole: Int?
    let isRoaming: Bool?
    let cluster: Int
    let leaverStatus: Int
    let partySize: Int?
    let heroVariant: Int?
}
