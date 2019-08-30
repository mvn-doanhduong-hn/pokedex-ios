//
//  PokemonFlow.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow

class PokemonFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .pokemons:
            return navigateToPokemonsScreen()
//        case .searchPokemons(let name):
//            return navigateToSearchPokemonsScreen(name)
        case .pokemonDetail(let id):
            return navigateToPokemonDetailScreen(id)
        default:
            return .none
        }
    }
    
    private func navigateToPokemonsScreen() -> FlowContributors {
        let viewModel = PokemonViewModel()
        let services = PokemonServices(pokemonNetwork: PokemonNetwork())
        let pokemonViewController = PokemonViewController.instantiate(withViewModel: viewModel, andServices: services)
        self.rootViewController.pushViewController(pokemonViewController, animated: true)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: pokemonViewController, withNextStepper: pokemonViewController.viewModel))
    }

    private func navigateToPokemonDetailScreen(_ id: String) -> FlowContributors {
        let viewModel = PokemonDetailViewModel(withPokemonId: id)
        let services = PokemonServices(pokemonNetwork: PokemonNetwork())
        let viewController = PokemonDetailViewController.instantiate(withViewModel: viewModel, andServices: services)
        self.rootViewController.present(viewController, animated: true, completion: nil)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}
