//
//  MoveFlow.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow

class MoveFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .moves:
            return navigateToMovesScreen()
//        case .searchMoves(let name):
//            return navigateToSearchMovesScreen(name)
        case .moveDetail(let name):
            return navigateToMoveDetailScreen(name)
        default:
            return .none
        }
    }
    
    private func navigateToMovesScreen() -> FlowContributors {
        let viewModel = MoveViewModel()
          let services = MoveServices(moveNetwork: MoveNetwork())
        let moveViewController = MoveViewController.instantiate(withViewModel: viewModel, andServices: services)
        self.rootViewController.pushViewController(moveViewController, animated: true)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: moveViewController, withNextStepper: moveViewController.viewModel))
    }
    
    private func navigateToMoveDetailScreen(_ name: String) -> FlowContributors {
        let viewModel = MoveDetailViewModel(withItemName: name)
        let services = MoveServices(moveNetwork: MoveNetwork())
        let viewController = MoveDetailViewController.instantiate(withViewModel: viewModel, andServices: services)
        self.rootViewController.present(viewController, animated: true, completion: nil)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}
