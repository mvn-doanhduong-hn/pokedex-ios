//
//  HomeServices.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

protocol HasHomeServices {
    var homeService: HomeService { get }
}

struct HomeServices: HasHomeServices {
    var homeService: HomeService
}

class HomeService {
    
}
