//
//  StatsPageView.swift
//  pokemondex
//
//  Created by MacMini2012 on 8/8/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class StatsPageView: NibView {
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var basicStatsView: BasicStatsView!
    @IBOutlet weak var weaknessesView: WeaknessesView!
    @IBOutlet weak var breedingView: BreedingView!
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)        
    }
    
    func setData(stats: Stats) {
        basicStatsView.setData(stats.basicStatses)
        setDataWeaknesses(weaknesses: stats.weaknesses)
        breedingView.setData(breeding: stats.breeding)        
    }
    
    func setDataWeaknesses(weaknesses: [Weakness]) {

        var weaknessesData: [Weakness] = []
        
        PokemonType.allCases.forEach {
            var tmpWeakness = Weakness(pokemonType: $0.rawValue, effect: 1)
            for weakness in weaknesses {
                if $0.rawValue.lowercased() == weakness.pokemonType.lowercased() {
                    tmpWeakness.effect = weakness.effect
                    break
                }
            }
            weaknessesData.append(tmpWeakness)
        }
        
        weaknessesView.setData(weaknessesData)
    }
    
}

