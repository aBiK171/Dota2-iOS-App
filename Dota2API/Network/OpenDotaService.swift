
import Foundation

protocol OpenDotaProtocol {
    func getHeroes() async throws -> [HeroesResponse]
    func getPlayers(id: Int) async throws -> PlayerResponse
    func getWinrate(id: Int) async throws -> WinLoseResponse
    func getRecentMatches(id: Int) async throws -> [RecentMatchesModel]
    func getProMatches() async throws -> [ProMatchesModel]
    func getTeam(id: Int) async throws -> TeamModel
    func getAllTeams() async throws -> [TeamModel]
}



final class OpenDotaService: OpenDotaProtocol {
   
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getHeroes() async throws -> [HeroesResponse] {
        try await networkService.request(OpenDotaRouter.getHeroes)
    }
    func getPlayers(id: Int) async throws -> PlayerResponse {
        try await networkService.request(OpenDotaRouter.getPlayers(id: id))
    }
    func getWinrate(id: Int) async throws -> WinLoseResponse {
        try await networkService.request(OpenDotaRouter.getWinrate(id: id))
    }
    func getRecentMatches(id: Int) async throws -> [RecentMatchesModel] {
        try await networkService.request(OpenDotaRouter.getRecentMatches(id: id))
    }
    func getProMatches() async throws -> [ProMatchesModel] {
        try await networkService.request(OpenDotaRouter.getProMatches)
    }
    func getTeam(id: Int) async throws -> TeamModel {
        try await networkService.request(OpenDotaRouter.getTeam(id: id))
    }
    
    func getAllTeams() async throws -> [TeamModel] {
        try await networkService.request(OpenDotaRouter.getAllTeams)
    }
   
}


