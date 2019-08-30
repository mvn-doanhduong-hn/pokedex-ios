//
//  CommonErrorResponse.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

struct CommonErrorResponse: Codable {
    let code: Int
    let message: String
}
