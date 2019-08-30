//
//  AbilitiesView.swift
//  pokemondex
//
//  Created by LTT on 8/24/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class AbilitiesView: NibView {
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }

}
