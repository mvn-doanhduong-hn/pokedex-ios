//
//  BaseHomeTableViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BaseHomeTableViewController: UITableViewController {

    var searchBar: UISearchController!
    var searchResults: [Any] = []
    private var previousRun = Date()
    private let minInterval = 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        setupSearchBar()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupSearchBar() {
        searchBar = UISearchController(searchResultsController: nil)
        searchBar.dimsBackgroundDuringPresentation = false
        searchBar.hidesNavigationBarDuringPresentation = false
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor.init(hexString: "dee8fa").cgColor, UIColor.init(hexString: "d8f5da").cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            
            if let image = Utils.getImageFrom(gradientLayer: gradient) {
                navigationBar.barTintColor = UIColor(patternImage: image)
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.barTintColor = UIColor(patternImage: image)
                    tabBar.tintColor = .black
                }
            }
        }
        navigationItem.searchController = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
}
