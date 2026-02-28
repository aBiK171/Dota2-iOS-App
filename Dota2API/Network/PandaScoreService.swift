//
//  PandaScoreService.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 25/02/26.
//

protocol PandaScoreProtocol {
    func getUpcomingMatches() async throws -> [MatchResponse]
    func getRunningMatches() async throws -> [MatchResponse]
    func getFinishedMatches() async throws -> [MatchResponse]
}

final class PandaScoreService: PandaScoreProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getUpcomingMatches() async throws -> [MatchResponse] {
        try await networkService.request(PandaScoreRouter.upcomingMatches)
    }
    func getRunningMatches() async throws -> [MatchResponse] {
        try await networkService.request(PandaScoreRouter.runningMatches)
    }
    func getFinishedMatches() async throws -> [MatchResponse] {
        try await networkService.request(PandaScoreRouter.finishedMatches)
    }
}
