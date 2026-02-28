//
//  APIRouter.swift
//  CatAPITutorial
//
//  Created by Abboskhon Rakhimov on 21/01/26.
//

import Foundation

enum OpenDotaRouter {
    case getPlayers(id: Int)
    case getWinrate(id: Int)
    case getRecentMatches(id: Int)
    case getProMatches
    case getHeroes
    case getTeam(id: Int)
    case getAllTeams
    case getProPlayers
}

extension OpenDotaRouter: Endpoint {
    
    var baseURL: URL {
        return URL(string: "https://api.opendota.com/api")!
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        
        headers.add(.json, forKey: .accept)
        return headers
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .getHeroes, .getProMatches, .getAllTeams, .getProPlayers:
            return .get
        case .getWinrate(let id), .getRecentMatches(let id), .getPlayers(let id), .getTeam(let id):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHeroes:
            return "heroStats"
        case .getPlayers(let id):
            return "players/\(id)"
        case .getWinrate(let id):
            return "players/\(id)/wl"
        case .getRecentMatches(let id):
            return "players/\(id)/recentMatches"
        case .getProMatches:
            return "proMatches"
        case .getTeam(let id):
            return "teams/\(id)"
        case .getAllTeams:
            return "teams"
        case .getProPlayers:
            return "proPlayers"
        }
        
    }
//    var queryParameters: [String: Any]? {
//                switch self {
//                case .getHeroes:
//                    return nil
//                case .getPlayers(let model):
//                    return model.dictionary
//                default:
//                    return nil
//                }
//            }
    
}
