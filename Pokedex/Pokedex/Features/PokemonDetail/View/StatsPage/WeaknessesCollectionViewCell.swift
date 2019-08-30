//
//  WeaknessesCollectionViewCell.swift
//  pokemondex
//
//  Created by LTT on 8/24/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class WeaknessesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var effectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(type: PokemonType, effect: String) {
        typeImageView.image = UIImage(named: type.image.lowercased())
        effectLabel.text = effect
    }
}
