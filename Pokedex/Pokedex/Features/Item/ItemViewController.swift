//
//  ItemViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

class ItemViewController: BaseHomeTableViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: ItemViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Items"
        searchBar.searchBar
            .rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestItemList.onNext(())
    }
    
    func bindViewModel() {
        viewModel.itemList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                switch result {
                case .success(let values):
                    print("Value: ", values.count)
                    self.searchResults = values
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error: ", error.description)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        let item = searchResults[indexPath.row] as! Item
        cell.itemImageView?.af_setImage(withURL: URL(string: item.image)!)
        cell.nameLabel?.text = item.name
        cell.priceLabel?.text = "\(item.price)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchResults[indexPath.row] as! Item
        viewModel.navigateToItemDetail(withItemName: item.name)
    }
    
}
