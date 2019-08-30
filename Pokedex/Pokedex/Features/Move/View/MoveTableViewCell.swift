//
//  MoveTableViewCell.swift
//  Pokedex
//
//  Created by LTT on 8/29/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setPokemonTypeView(pokemonType: String) {
        for subUIView in typeStackView.arrangedSubviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        
        let imageView = UIImageView(image: UIImage(named: (PokemonType.init(rawValue: pokemonType)?.image.lowercased())!)!)
        imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        typeStackView.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
