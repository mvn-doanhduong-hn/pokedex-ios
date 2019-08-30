//
//  SplashService.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

protocol HasSplashServices {
    var splashService: SplashService { get }
    var appStateService: AppStateService { get }
}

struct SplashServices: HasSplashServices {
    var splashService: SplashService
    var appStateService: AppStateService
}

class SplashService {
    
}
