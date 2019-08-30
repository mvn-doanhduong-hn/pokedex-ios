//
//  WeaknessesView.swift
//  pokemondex
//
//  Created by LTT on 8/24/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class WeaknessesView: NibView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var weaknesses: [Weakness] = []
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
        registerCollectionViewCell()
    }
    
    func registerCollectionViewCell() {
        let nib = UINib.init(nibName: "WeaknessesCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "WeaknessesCollectionViewCell")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func setData(_ weaknesses: [Weakness]) {
        self.weaknesses.removeAll()
        self.weaknesses = weaknesses
        self.collectionView.reloadData()
    }

}

extension WeaknessesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaknesses.count
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 6
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeaknessesCollectionViewCell", for: indexPath) as! WeaknessesCollectionViewCell
        
        let weakness = weaknesses[indexPath.row]
        
        cell.setData(type: PokemonType.init(rawValue: weakness.pokemonType)!, effect: "\(Utils.numberFormat(NSNumber(value: weakness.effect)))x")
        return cell
    }
  
}
