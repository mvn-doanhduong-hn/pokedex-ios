//
//  HomeFlow.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow

class HomeFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    private lazy var rootViewController: RootTabBarViewController = {
        let rootTabBarController = RootTabBarViewController.instantiate()
        return rootTabBarController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .home:
            return navigationToHome()
        default:
            return .none
        }
    }
    
    private func navigationToHome() -> FlowContributors {
        
        let pokemonFlow = PokemonFlow()
        let moveFlow = MoveFlow()
        let itemFlow = ItemFlow()
        
        Flows.whenReady(flow1: pokemonFlow, flow2: moveFlow, flow3: itemFlow) { (root1, root2, root3) in
            let pokemonTabBarItem = UITabBarItem(title: "Pokemon", image: UIImage(named: "TabPokemon"), selectedImage: nil)
            let moveTabBarItem = UITabBarItem(title: "Move", image: UIImage(named: "TabMove"), selectedImage: nil)
            let itemTabBarItem = UITabBarItem(title: "Item", image: UIImage(named: "TabItem"), selectedImage: nil)
                  
            root1.tabBarItem = pokemonTabBarItem
            root2.tabBarItem = moveTabBarItem
            root3.tabBarItem = itemTabBarItem
                        
            self.rootViewController.setViewControllers([root1, root2, root3], animated: true)
        }
        
        return FlowContributors.multiple(flowContributors: [
            FlowContributor.contribute(withNextPresentable: pokemonFlow, withNextStepper: OneStepper.init(withSingleStep: AppStep.pokemons)),
            FlowContributor.contribute(withNextPresentable: moveFlow, withNextStepper: OneStepper.init(withSingleStep: AppStep.moves)),
            FlowContributor.contribute(withNextPresentable: itemFlow, withNextStepper: OneStepper.init(withSingleStep: AppStep.items))
            ])
        
    }
}
