//
//  BaseDetailViewController.swift
//  Pokedex
//
//  Created by LTT on 8/29/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

class BaseDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setRoundCornerView(_ view: UIView) {
        view.roundCorners(corners: [.topLeft, .topRight], radius: 48)
    }
    
}
