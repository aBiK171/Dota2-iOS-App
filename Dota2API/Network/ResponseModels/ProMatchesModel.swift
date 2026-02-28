//
//  ProMatchesModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 23/02/26.
//

struct ProMatchesModel: Codable, Hashable {
    let matchId: Int
    let duration: Int
    let startTime: Int?
    let radiantTeamId: Int?
    let radiantName: String?
    let direTeamId: Int?
    let direName: String?
    let leagueId: Int?
    let leagueName: String?
    let seriesId: Int? 
    let seriesType: Int?
    let radiantScore: Int?
    let direScore: Int?
    let radiantWin: Bool?
    let version: Int?
}
