import Foundation

struct MatchResponse: Codable, Hashable {
    let id: Int
    let status: String?
    let beginAt: String?
    let league: LeagueResponse?
    let opponents: [OpponentResponse]?
    let results: [ResultResponse]?
}

struct LeagueResponse: Codable, Hashable {
    let name: String?
    let imageUrl: String?
}

struct OpponentResponse: Codable, Hashable {
    let opponent: TeamResponse?
}

struct TeamResponse: Codable, Hashable {
    let name: String?
    let imageUrl: String?
}

struct ResultResponse: Codable, Hashable {
    let score: Int?
}


