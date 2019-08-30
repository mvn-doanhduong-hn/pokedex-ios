//
//  AppError.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

struct AppError: Swift.Error, CustomStringConvertible {
    let code: Int?
    let description: String
    let errorResponse: Data?
}

extension Error {
    func toAppError(code: Int? = nil, description: String, errorResponse: Data? = nil) -> AppError {
        return AppError(code: code, description: self.localizedDescription, errorResponse: errorResponse)
    }
}
