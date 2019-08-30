//
//  SplashViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class SplashViewModel: ServicesViewModel {
    typealias Services = SplashServices
    internal var services: Services!
    private let disposeBag = DisposeBag()
    let steps: PublishRelay<Step> = PublishRelay<Step>()
    
}

extension SplashViewModel: Stepper {
    
    func onSplashComplete() {
        self.steps.accept(AppStep.splashComplete)
    }
}
