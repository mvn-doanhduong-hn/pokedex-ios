//
//  BasicStatsViewTableViewCell.swift
//  pokemondex
//
//  Created by LTT on 8/23/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit
import GradientProgress

class BasicStatsViewTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var progressView: GradientProgressBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progressView.gradientColors = [UIColor(hexString: "6CBDE4").cgColor, UIColor(hexString: "4A90DD").cgColor]
        progressView.trackTintColor = UIColor(hexString: "F0F0F0")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
