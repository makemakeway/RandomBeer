//
//  BeerModel.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/20.
//

import Foundation

struct BeerModel: Codable {
    let name: String
    let id: Int
    let tag: String
    let description: String
    let imageUrl: String
    let pairingFood: [String]
    let tips: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case tag = "tagline"
        case description
        case imageUrl = "image_url"
        case pairingFood = "food_pairing"
        case tips = "brewers_tips"
    }
}
