//
//  HeroLoreProvider.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 27/02/26.
//

import Foundation

final class HeroLoreProvider {
    
    static let shared = HeroLoreProvider()
    
    private var loreDictionary: [String: String] = [:]
    
    private init() {
        loadLore()
    }
    
    private func loadLore() {
        guard let url = Bundle.main.url(forResource: "HeroLore", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([String: String].self, from: data) else {
            print("Failed to load HeroLore.json")
            return
        }
        
        loreDictionary = decoded
    }
    
    func lore(for heroKey: String) -> String {
        loreDictionary[heroKey.lowercased()] ?? "No description available."
    }
}   
