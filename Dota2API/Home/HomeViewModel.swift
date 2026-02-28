//
//  HomeViewModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//

import UIKit

final class HomeViewModel {
    
    let pandaService: PandaScoreProtocol
    let openDotaService: OpenDotaProtocol
    
  
    
    enum HomeItem: Hashable {
        case match(MatchOverview)
        case hero(Hero)
    }
    
    struct HomeSection {
        let type: HomeSectionType
        let items: [HomeItem]
        
        
    }
    
    enum HomeSectionType {
        case upcoming
        case live
        case heroes
        case finished
    }
    
    
    private(set) var sections: [HomeSection] = []
    
    init(pandaService: PandaScoreProtocol, openDotaService: OpenDotaProtocol) {
        self.pandaService = pandaService
        self.openDotaService = openDotaService
    }
    
    
    
    
    
    func load() async throws {
        
        async let live = pandaService.getRunningMatches()
        async let upcoming = pandaService.getUpcomingMatches()
        async let heroes = openDotaService.getHeroes()
        async let finished = pandaService.getFinishedMatches()

        let (liveData, upcomingData, heroesData, finishedData) =
        try await (live, upcoming, heroes, finished)
        
        buildSections(
            running: liveData,
            upcoming: upcomingData,
            heroes: heroesData,
            finished: finishedData
        )
    }
    
    private func mapToOverview(_ response: MatchResponse) -> MatchOverview {
        
        let radiantScore = response.results?.first?.score ?? 0
        let direScore = response.results?.last?.score ?? 0
        
        let scoreText = response.status == "running"
            ? "\(radiantScore) : \(direScore)"
            : nil
        
        let statusText = response.status?.uppercased() ?? "UNKNOWN"
        
        let timeText: String
        if response.status == "running" {
            timeText = "LIVE"
        } else {
            timeText = response.beginAt ?? "SOON"
        }
        
        return MatchOverview(
            id: response.id,
            leagueName: response.league?.name,
            leagueLogo: response.league?.imageUrl,
            radiantTeam: response.opponents?.first?.opponent?.name ?? "Radiant",
            radiantLogo: response.opponents?.first?.opponent?.imageUrl,
            direTeam: response.opponents?.last?.opponent?.name ?? "Dire",
            direLogo: response.opponents?.last?.opponent?.imageUrl,
            scoreText: scoreText,
            statusText: statusText,
            timeText: timeText
        )
    }
    
    private func mapToProOverview(_ model: ProMatchesModel) -> ProMatchOverview {
        
        let radiantScore = model.radiantScore ?? 0
        let direScore = model.direScore ?? 0
        
        let scoreText = "\(radiantScore) : \(direScore)"
        
        let minutes = model.duration / 60
        let seconds = model.duration % 60
        
        let durationText = model.duration > 0
            ? String(format: "%02d:%02d", minutes, seconds)
            : "—"
        
        return ProMatchOverview(
            id: model.matchId,
            duration: model.duration,
            startTime: model.startTime,
            
            radiantTeamId: model.radiantTeamId,
            radiantName: model.radiantName,
            
            direTeamId: model.direTeamId,
            direName: model.direName,
            
            leagueId: model.leagueId,
            leagueName: model.leagueName,
            
            seriesId: model.seriesId,
            seriesType: model.seriesType,
            
            radiantScore: model.radiantScore,
            direScore: model.direScore,
            
            radiantWin: model.radiantWin,
            version: model.version,
            
            scoreText: scoreText,
            durationText: durationText
        )
    }
    
    private func buildSections(
        running: [MatchResponse],
        upcoming: [MatchResponse],
        heroes: [HeroesResponse],
        finished: [MatchResponse]
    ) {

        var newSections: [HomeSection] = []

        if !upcoming.isEmpty {
            newSections.append(
                HomeSection(
                    type: .upcoming,
                    items: upcoming.prefix(5).map { .match(mapToOverview($0)) }
                )
            )
        }

        if !running.isEmpty {
            newSections.append(
                HomeSection(
                    type: .live,
                    items: running.prefix(5).map { .match(mapToOverview($0)) }
                )
            )
        }

        if !finished.isEmpty {
            newSections.append(
                HomeSection(
                    type: .finished,
                    items: finished.prefix(5).map { .match(mapToOverview($0)) }
                )
            )
        }

        let mappedHeroes = heroes.map { mapToHero($0) }

        let topHeroes = mappedHeroes
            .sorted { $0.pubPick > $1.pubPick }
            .prefix(5)

        if !topHeroes.isEmpty {
            newSections.append(
                HomeSection(
                    type: .heroes,
                    items: topHeroes.map { .hero($0) }
                )
            )
        }

        sections = newSections
    }
    
    private func mapToHero(_ response: HeroesResponse) -> Hero {
        return Hero(
            id: response.id,
            apiName: response.name,
            name: response.localizedName,
            attribute: response.primaryAttr,
            attackType: response.attackType,
            roles: response.roles,
            image: response.img,
            icon: response.icon,
            health: response.baseHealth,
            mana: response.baseMana,
            armor: response.baseArmor,
            speed: response.moveSpeed,
            strength: response.baseStr,
            agility: response.baseAgi,
            intelligence: response.baseInt,
            strGain: response.strGain,
            agiGain: response.agiGain,
            intGain: response.intGain,
            baseAttackMin: response.baseAttackMin,
            baseAttackMax: response.baseAttackMax,
            attackRange: response.attackRange,
            attackRate: response.attackRate,
            baseMr: response.baseMr,
            dayVision: response.dayVision,
            nightVision: response.nightVision,
            turboPicks: response.turboPicks,
            turboWins: response.turboWins,
            proPick: response.proPick,
            proWin: response.proWin,
            
            pubPick: response.pubPick,
            pubWin: response.pubWin
        )
    }
    
    
    
    
}


