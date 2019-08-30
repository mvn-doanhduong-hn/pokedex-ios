//
//  Breeding.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

struct Breeding: Codable {
    let eggGroup: [String]
    let hatchTime: HatchTime
    let femaleGender: Double
}
