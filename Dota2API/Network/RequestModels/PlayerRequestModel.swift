//
//  PlayerRequestModel.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

struct PlayerRequestModel {
    let id: Int
    
    var dictionary: [String: Any] {
        ["q": id]
    }
}
