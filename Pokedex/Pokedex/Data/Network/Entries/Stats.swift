//
//  Stats.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

struct Stats: Codable {
    let basicStatses: [BasicStats]
    let weaknesses: [Weakness]
    let breeding: Breeding
}
