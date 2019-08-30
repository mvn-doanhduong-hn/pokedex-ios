//
//  BasicStatsView.swift
//  pokemondex
//
//  Created by LTT on 8/23/19.
//  Copyright © 2019 Pokemondex. All rights reserved.
//

import UIKit

class BasicStatsView: NibView {
        
    @IBOutlet weak var tableView: UITableView!
    
    var basicStatses: [BasicStats] = []
    
    override func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
        registerTableCell()
    }
    
    func registerTableCell() {
        let nib = UINib.init(nibName: "BasicStatsViewTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BasicStatsViewTableViewCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func setData(_ basicStatses: [BasicStats]) {
        self.basicStatses = basicStatses
        self.tableView.reloadData()
    }
}

extension BasicStatsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basicStatses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicStatsViewTableViewCell", for: indexPath) as! BasicStatsViewTableViewCell
        
        let basciStats = basicStatses[indexPath.row]
               
        cell.nameLabel.text = basciStats.name
        cell.valueLabel.text = "\(basciStats.value)"
        cell.progressView.setProgress(0.5, animated: true)
        let value = Float(basciStats.value)/Float(basciStats.maxValue)
        cell.progressView.progress = value
       
        return cell
    }
}
