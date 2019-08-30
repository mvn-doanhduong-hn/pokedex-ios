//
//  AppStep.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import RxFlow

enum AppStep: Step {
    case splash
    case splashComplete
    
    case home
    
    case pokemons
    case searchPokemons(name: String)
    case pokemonDetail(id: String)
    
    case moves
    case searchMoves(name: String)
    case moveDetail(name: String)
    
    case items
    case searchItems(name: String)
    case itemDetail(name: String)
}
