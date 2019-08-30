//
//  Move.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

struct Move: Codable {
    let name: String
    let level: Int?
    let type: String
    let effects: String?
    let power: Int?
    let accuracy: Int?
    let pp: Int?
}
