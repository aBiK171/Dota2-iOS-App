//
//  HeroesViewModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 26/02/26.
//

import UIKit

final class HeroesViewModel {
    
    private let openDotaService : OpenDotaProtocol
    
    private(set) var heroes: [Hero] = []
        private(set) var filteredHeroes: [Hero] = []
    
    init(openService: OpenDotaProtocol) {
        self.openDotaService = openService
    }
    
    func fetchHeroes() async throws {
        let response = try await openDotaService.getHeroes()
        let mapped = response.map { mapToHero(from: $0) }
        self.heroes = mapped
        self.filteredHeroes = mapped
    }

    func filter(by attribute: String) {
        filteredHeroes = heroes.filter { $0.attribute == attribute }
    }
    
    private func mapToHero(from item: HeroesResponse) -> Hero {
        
        return Hero(id: item.id,
                    apiName: item.name,
                    name: item.localizedName,
                    attribute: item.primaryAttr,
                    attackType: item.attackType,
                    roles: item.roles,
                    image: item.img,
                    icon: item.icon,
                    health: item.baseHealth,
                    mana: item.baseMana,
                    armor: item.baseArmor,
                    speed: item.moveSpeed,
                    strength: item.baseStr,
                    agility: item.baseAgi,
                    intelligence: item.baseInt,
                    strGain: item.strGain,
                    agiGain: item.agiGain,
                    intGain: item.intGain,
                    baseAttackMin: item.baseAttackMin,
                    baseAttackMax: item.baseAttackMax,
                    attackRange: item.attackRange,
                    attackRate: item.attackRate,
                    baseMr: item.baseMr,
                    dayVision: item.dayVision,
                    nightVision: item.nightVision,
                    turboPicks: item.turboPicks,
                    turboWins: item.turboWins,
                    proPick: item.proPick,
                    proWin: item.proWin,
                    pubPick: item.pubPick,
                    pubWin: item.pubWin
        )
       
        
    }
   
}
