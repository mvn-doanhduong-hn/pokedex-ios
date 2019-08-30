//
//  PokemonServices.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

protocol HasPokemonNetwork {
    var pokemonNetwork: PokemonNetwork { get }
}

struct PokemonServices: HasPokemonNetwork {
    let pokemonNetwork: PokemonNetwork
}
