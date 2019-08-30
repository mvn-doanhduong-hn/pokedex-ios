//
//  Pokemon.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id, name: String
    let image: String
    let pokemonDescription: String
    let pokemonTypes: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case pokemonDescription = "description"
        case pokemonTypes
    }
}
