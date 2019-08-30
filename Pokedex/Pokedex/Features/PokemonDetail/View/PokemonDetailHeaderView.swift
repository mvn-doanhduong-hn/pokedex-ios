//
//  PokemonDetailHeaderView.swift
//  Pokedex
//
//  Created by LTT on 8/29/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

class PokemonDetailHeaderView: NibView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var roundCornerView: UIView!
    @IBOutlet weak var menuBarView: UIView!
    @IBOutlet weak var pokemonMenuLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeStackView: UIStackView!
    @IBOutlet weak var pokemonEffectsLabel: UILabel!
    @IBOutlet weak var pokemonType1ImageView: UIImageView!
    @IBOutlet weak var pokemonType2ImageView: UIImageView!
    @IBOutlet weak var pokemonType3ImageView: UIImageView!
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 525))
    }
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.contentView.setBackgroundGradientColor(fromHexString: "559EDF", toHexString: "69B9E3")
        setRoundCornerView()
        
        addSubview(view)
    }
    
    func setData(pokemon: Pokemon) {
        pokemonMenuLabel.text = pokemon.name
        pokemonNameLabel.text = pokemon.name
        pokemonImageView.af_setImage(withURL: URL(string: pokemon.image)!)
        pokemonEffectsLabel.text = pokemon.pokemonDescription
        
        for subUIView in pokemonTypeStackView.arrangedSubviews {
            subUIView.isHidden = true
        }
        
        let pokemonTypeNumber = pokemon.pokemonTypes.count
        
        if pokemonTypeNumber > 0 {
            pokemonType1ImageView.image = UIImage(named: PokemonType(rawValue: pokemon.pokemonTypes[0])?.imageWithText.lowercased() ?? "type_normal_text")
            pokemonType1ImageView.isHidden = false
            if pokemonTypeNumber == 2 {
                pokemonType1ImageView.contentMode = .right
            } else {
                pokemonType1ImageView.contentMode = .center
            }
            let gradientColors = Utils.getGradientColors(pokemonType: PokemonType(rawValue: pokemon.pokemonTypes[0])!)
            self.contentView.setBackgroundGradientColor(fromColor: gradientColors[0], toColor: gradientColors[1])
        }
        if pokemonTypeNumber > 1 {
            pokemonType2ImageView.image = UIImage(named: PokemonType(rawValue: pokemon.pokemonTypes[1])?.imageWithText.lowercased() ?? "type_normal_text")
            pokemonType2ImageView.isHidden = false
            if pokemonTypeNumber == 2 {
                pokemonType2ImageView.contentMode = .left
            } else {
                pokemonType2ImageView.contentMode = .center
            }
        }
        if pokemonTypeNumber > 2 {
            pokemonType3ImageView.image = UIImage(named: PokemonType(rawValue: pokemon.pokemonTypes[2])?.imageWithText.lowercased() ?? "type_normal_text")
            pokemonType3ImageView.isHidden = false
            pokemonType3ImageView.contentMode = .center
        }
    }
    
    func setRoundCornerView() {
        roundCornerView.roundCorners(corners: [.topLeft, .topRight], radius: 48)
    }
    
    func isTitleBarHidden() -> Bool {
        return self.pokemonMenuLabel.isHidden
    }
    
    /// Fade in a view with a duration
    ///
    /// Parameter duration: custom animation duration
    func fadeInTitleBar(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.pokemonMenuLabel.alpha = 1.0
            self.pokemonMenuLabel.isHidden = false
        })
    }
    
    /// Fade out a view with a duration
    ///
    /// - Parameter duration: custom animation duration
    func fadeOutTitleBar(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.pokemonMenuLabel.alpha = 0.0
            self.pokemonMenuLabel.isHidden = true
        })
    }

}
