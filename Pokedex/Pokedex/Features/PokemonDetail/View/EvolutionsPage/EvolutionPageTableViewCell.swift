//
//  EvolutionPageTableViewCell.swift
//  pokemondex
//
//  Created by LTT on 8/23/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class EvolutionPageTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var evolutionPokemonImageView: UIImageView!
    @IBOutlet weak var evolutionPokemonNameLabel: UILabel!
    @IBOutlet weak var evolutionLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
