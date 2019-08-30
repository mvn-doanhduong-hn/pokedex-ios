//
//  MovePageTableViewCell.swift
//  pokemondex
//
//  Created by LTT on 8/23/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class MovePageTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
