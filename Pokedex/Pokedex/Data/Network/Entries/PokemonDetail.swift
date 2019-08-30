//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct PokemonDetail: Codable {
    let pokemon: Pokemon
    let stats: Stats
    let evolutions: [Evolution]
    let moves: [Move]
}
