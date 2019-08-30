//
//  MoveServices.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

protocol HasMoveNetwork {
    var moveNetwork: MoveNetwork { get }
}

struct MoveServices: HasMoveNetwork {
    let moveNetwork: MoveNetwork
}
