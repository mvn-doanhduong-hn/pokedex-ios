//
//  PersistenceManager.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    static let shared = PersistenceManager()
    private let defaults: UserDefaults
    
    private init () {
        defaults = UserDefaults.standard
    }
    
    public func isOnboardDone() -> Bool {
        return defaults.bool(forKey: Constants.AppSettings.onboardCompletion)
    }
    
    public func setOnboardDone() {
        defaults.set(true, forKey: Constants.AppSettings.onboardCompletion)
    }
    
}
