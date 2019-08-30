//
//  BreedingView.swift
//  pokemondex
//
//  Created by LTT on 8/24/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class BreedingView: NibView {
    
    @IBOutlet weak var eggGroupStackView: UIStackView!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var cyclesLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }

    func setData(breeding: Breeding) {
        stepsLabel.text = "\(breeding.hatchTime.steps) Steps"
        cyclesLabel.text = "\(breeding.hatchTime.cycles) Steps"
        femaleLabel.text = "\(Utils.numberFormat(NSNumber(value: breeding.femaleGender)))%"
        maleLabel.text = "\(Utils.numberFormat(NSNumber(value: 100 - breeding.femaleGender)))%"
        
        for subUIView in eggGroupStackView.arrangedSubviews {
            subUIView.removeFromSuperview()
        }
        
        for eggGroup in breeding.eggGroup {
            let eggGroupLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            eggGroupLabel.center = CGPoint(x: 160, y: 284)
            eggGroupLabel.textAlignment = .center
            eggGroupLabel.text = eggGroup
            
            eggGroupStackView.addArrangedSubview(eggGroupLabel)
        }
    }

}
