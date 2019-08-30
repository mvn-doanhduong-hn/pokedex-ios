//
//  SplashViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

import Reusable
import UIKit
import RxSwift

class SplashViewController: UIViewController, StoryboardBased, ViewModelBased {
    var viewModel: SplashViewModel!
    
    private let disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
            self.viewModel.onSplashComplete()
        })
    }
    
    func bindViewModel() {
        
    }
    
}
