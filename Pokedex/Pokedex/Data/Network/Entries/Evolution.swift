//
//  Evolution.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

// MARK: - Evolution
struct Evolution: Codable {
    let pokemonName: String
    let pokemonImage: String
    let evolutionPokemonName: String
    let evolutionpokemonImage: String
    let evolutionLevel: Int
}
