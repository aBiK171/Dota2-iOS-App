import Foundation

struct HeroesResponse: Decodable {
    
    let id: Int
    let name: String
    let localizedName: String
    let primaryAttr: String
    let attackType: String
    let roles: [String]
    
    let img: String
    let icon: String
    
    // Base stats
    let baseHealth: Int
    let baseHealthRegen: Double?
    let baseMana: Int
    let baseManaRegen: Double?
    let baseArmor: Double?
    let baseMr: Int?
    
    let baseAttackMin: Int
    let baseAttackMax: Int
    
    let baseStr: Int
    let baseAgi: Int
    let baseInt: Int
    
    let strGain: Double
    let agiGain: Double
    let intGain: Double
    
    let attackRange: Int
    let projectileSpeed: Int
    let attackRate: Double
    let baseAttackTime: Int?
    let attackPoint: Double?
    
    let moveSpeed: Int
    let turnRate: Double?
    
    let legs: Int?
    
    let dayVision: Int
    let nightVision: Int
    
    // Turbo
    let turboPicks: Int
    let turboWins: Int
    
    // Pro
    let proPick: Int
    let proWin: Int
    let proBan: Int
    
    // Pub
    let pubPick: Int
    let pubWin: Int
}
