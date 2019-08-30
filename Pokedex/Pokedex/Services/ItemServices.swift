//
//  ItemServices.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

protocol HasItemNetwork {
    var itemNetwork: ItemNetwork { get }
}

struct ItemServices: HasItemNetwork {
    let itemNetwork: ItemNetwork
}
