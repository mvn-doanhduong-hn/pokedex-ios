//
//  SplashFlow.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow
import UIKit

class SplashFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .splash:
            return navigationToSplashScreen()
        case .splashComplete:
            return completeSplash()
        default:
            return .none
        }
    }
    
    private func navigationToSplashScreen () -> FlowContributors {
        let appStateService = AppStateService()
        let splashService = SplashService()
        let splashServices = SplashServices(splashService: splashService, appStateService: appStateService)
        
        let splashViewController = SplashViewController.instantiate(withViewModel: SplashViewModel(), andServices: splashServices)
        
        self.rootViewController.pushViewController(splashViewController, animated: false)
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: splashViewController, withNextStepper: splashViewController.viewModel))
        
    }
    
    private func completeSplash() -> FlowContributors {
        return FlowContributors.end(forwardToParentFlowWithStep: AppStep.splashComplete)
    }
}
