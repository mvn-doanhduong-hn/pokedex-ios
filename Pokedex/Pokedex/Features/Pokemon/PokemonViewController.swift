//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class PokemonViewController: BaseHomeTableViewController, StoryboardBased, ViewModelBased {
 
    var viewModel: PokemonViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemons"
        
        searchBar.searchBar
            .rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestPokemonList.onNext(())
    }
    
    func bindViewModel() {
        viewModel.pokemonList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                switch result {
                case .success(let pokemons):
                    self.searchResults = pokemons
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemon = searchResults[indexPath.row] as! Pokemon
        cell.pokemonNameLabel?.text = pokemon.name
        cell.pokemonIDLabel?.text = "#\(pokemon.id)"
        cell.pokemonImage?.af_setImage(withURL: URL(string: pokemon.image)!)
        cell.setPokemonTypesView(pokemonTypes: pokemon.pokemonTypes)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = searchResults[indexPath.row] as! Pokemon
        viewModel.navigateToPokemonDetail(id: pokemon.id)
    }
}
