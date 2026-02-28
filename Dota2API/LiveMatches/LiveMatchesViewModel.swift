//
//  LiveMatchesViewModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 25/02/26.
//
import Foundation

@MainActor
final class LiveMatchesViewModel {

    private let pandaService: PandaScoreProtocol
    private(set) var upcoming: [MatchOverview] = []
    private(set) var running: [MatchOverview] = []
    
    init(pandaService: PandaScoreProtocol) {
        self.pandaService = pandaService
    }
    
    func fetchUpcoming() async {
            do {
                let response = try await pandaService.getUpcomingMatches()
                upcoming = response.compactMap { mapToOverview(from: $0) }
            } catch {
                print("Upcoming error:", error)
            }
        }
        
        // MARK: - Fetch Running
        
        func fetchRunning() async {
            do {
                let response = try await pandaService.getRunningMatches()
                running = response.compactMap { mapToOverview(from: $0) }
            } catch {
                print("Running error:", error)
            }
        }
    
    private func mapToOverview(from item: MatchResponse) -> MatchOverview? {
        
        guard
            let firstTeam = item.opponents?.first?.opponent,
            let secondTeam = item.opponents?.last?.opponent
        else { return nil }
        
        let score1 = item.results?.first?.score
        let score2 = item.results?.last?.score
        print("Name: ", item.league?.name)
        let scoreText: String? = {
            if let s1 = score1, let s2 = score2 {
                return "\(s1) - \(s2)"
            }
            return nil
        }()
        
        return MatchOverview(
            id: item.id,
            leagueName: item.league?.name,
            leagueLogo: item.league?.imageUrl,
            radiantTeam: firstTeam.name ?? "Radiant",
            radiantLogo: firstTeam.imageUrl,
            direTeam: secondTeam.name ?? "Dire",
            direLogo: secondTeam.imageUrl,
            scoreText: scoreText,
            statusText: (item.status ?? "").uppercased(),
            timeText: formattedTime(from: item.beginAt, status: item.status)
            
        )
       
        
    }
    
    private func formattedTime(from string: String?, status: String?) -> String {
        guard
            let string,
            let date = ISO8601DateFormatter().date(from: string)
        else { return "TBD" }

        if status == "running" {
            let seconds = Int(Date().timeIntervalSince(date))
            let minutes = seconds / 60
            let remaining = seconds % 60
            return String(format: "%02d:%02d", minutes, remaining)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM HH:mm"
            return formatter.string(from: date)
        }
    }
    
}
