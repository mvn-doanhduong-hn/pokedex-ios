//
//  ItemFlow.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow

class ItemFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .items:
            return navigateToItemsScreen()
            //        case .searchPokemons(let name):
        //            return navigateToSearchPokemonsScreen(name)
        case .itemDetail(let name):
            return navigateToItemDetailScreen(name)
        default:
            return .none
        }
    }
    
    private func navigateToItemsScreen() -> FlowContributors {
        let viewModel = ItemViewModel()
        let services = ItemServices(itemNetwork: ItemNetwork())
        let itemViewController = ItemViewController.instantiate(withViewModel: viewModel, andServices: services)
        self.rootViewController.pushViewController(itemViewController, animated: true)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: itemViewController, withNextStepper: itemViewController.viewModel))
    }

    private func navigateToItemDetailScreen(_ name: String) -> FlowContributors {
        let viewModel = ItemDetailViewModel(itemName: name)
        let services = ItemServices(itemNetwork: ItemNetwork())
        let viewController = ItemDetailViewController.instantiate(withViewModel: viewModel, andServices: services)
        self.rootViewController.present(viewController, animated: true, completion: nil)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}
