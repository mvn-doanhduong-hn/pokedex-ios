//
//  MoveViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

class MoveViewController: BaseHomeTableViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: MoveViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Moves"
        searchBar.searchBar
            .rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestMoveList.onNext(())
    }
    
    func bindViewModel() {
        viewModel.moveList
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath) as! MoveTableViewCell
        
        let move = searchResults[indexPath.row] as! Move
        cell.nameLabel?.text = move.name
        cell.setPokemonTypeView(pokemonType: move.type)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let move = searchResults[indexPath.row] as! Move
        viewModel.navigateToMoveDetail(name: move.name)
    }
    
}
