//
//  PokemonNetwork.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxSwift

final class PokemonNetwork {
    
    private let network: Network
    
    init() {
        self.network = Network()
    }
    
    public func searchPokemon(_ name: String) -> Observable<Result<PokemonList, AppError>> {
        return network.performRequest(route: APIRouter.searchPokemons(name: name))
    }
    
    public func pokemonDetail(_ id: String) -> Observable<Result<PokemonDetail, AppError>> {
        return network.performRequest(route: APIRouter.pokemonDetail(id: id))
    }
    
}
