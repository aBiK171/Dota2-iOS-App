//
//  PandaScoreRouter.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 25/02/26.
//

import Foundation

enum PandaScoreRouter {
    case upcomingMatches
    case runningMatches
    case finishedMatches
}

extension PandaScoreRouter: Endpoint {
    
    var baseURL: URL {
        URL(string: "https://api.pandascore.co")!
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add("Bearer MGnwUFFntjG2k7Cx7KNy__v6d9gpNve8wmTJFBhqwpVYNgP-ADU", forKey: "Authorization")
        return headers
    }
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .upcomingMatches:
            return "dota2/matches/upcoming"
        case .runningMatches:
            return "dota2/matches/running"
        case .finishedMatches:
            return "dota2/matches"
        }
    }
    var queryParameters: [String: Any]? {
            switch self {
            case .finishedMatches:
                return [
                    "status": "finished",
                    "sort": "-end_at",
                    "per_page": 10
                ]
            default:
                return nil
            }
        }
}
