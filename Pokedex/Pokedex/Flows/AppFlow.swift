//
//  AppFlow.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxFlow
import RxCocoa

class AppFlow: Flow {
    
    private let rootWindow: UIWindow
    
    var root: Presentable {
        return rootWindow
    }
    
    init(with window: UIWindow) {
        self.rootWindow = window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none}
        switch step {
        case .splash:
            return navigationToSplashScreen()
            
        case .splashComplete:
            return navigateToHomeScreen()            
            
        default:
            return .none
        }
    }
    
    private func navigationToSplashScreen () -> FlowContributors {
        let splashFlow = SplashFlow()
        Flows.whenReady(flow1: splashFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: splashFlow, withNextStepper: OneStepper.init(withSingleStep: AppStep.splash)))
    }
    
    private func navigateToHomeScreen() -> FlowContributors {
        
        let homeFlow = HomeFlow()
        Flows.whenReady(flow1: homeFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        
        return FlowContributors.one(flowContributor: FlowContributor.contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper.init(withSingleStep: AppStep.home)) )
        
    }
    
}
