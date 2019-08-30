//
//  EvolutionsPageView.swift
//  pokemondex
//
//  Created by MacMini2012 on 8/8/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class EvolutionsPageView: NibView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var evolutions: [Evolution] = []
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
        
        registerTableCell()
    }
    
    func registerTableCell() {
        let nib = UINib.init(nibName: "EvolutionPageTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "EvolutionPageTableViewCell")
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func setData(_ evolutions: [Evolution]) {
        self.evolutions = evolutions
        self.tableView.reloadData()
    }
}

extension EvolutionsPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evolutions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EvolutionPageTableViewCell", for: indexPath) as! EvolutionPageTableViewCell
        
        let evolution = evolutions[indexPath.row]
        cell.pokemonImageView?.af_setImage(withURL: URL(string: evolution.pokemonImage)!)
        cell.pokemonNameLabel.text = evolution.pokemonName
        cell.evolutionPokemonImageView?.af_setImage(withURL: URL(string: evolution.evolutionpokemonImage)!)
        cell.evolutionPokemonNameLabel.text = evolution.evolutionPokemonName
        cell.evolutionLevelLabel.text = "Lv.\(evolution.evolutionLevel)"
        
        return cell
    }
}
