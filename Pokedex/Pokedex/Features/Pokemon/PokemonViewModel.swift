//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class PokemonViewModel: ServicesViewModel {
    typealias Services = PokemonServices
    var services: Services!
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    public let requestPokemonList: AnyObserver<Void>
    public var pokemonList: Observable<Result<PokemonList, AppError>> {
        return pokemonListSubject.asObservable()
    }
    
    private let pokemonListSubject = PublishSubject<Result<PokemonList, AppError>>()
    var searchText = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    init() {
        let _requestPokemonList = PublishSubject<Void>()
        self.requestPokemonList = _requestPokemonList.asObserver()
        _requestPokemonList
            .flatMap { [unowned self] _ -> Observable<Result<PokemonList, AppError>> in
                return self.services.pokemonNetwork.searchPokemon(self.searchText.value)
            }.bind(to: pokemonListSubject)
            .disposed(by: disposeBag)
        
        searchText
            .skip(1)
            .throttle(0.5, latest: true, scheduler: MainScheduler.instance)
            .asObservable().subscribe(onNext: { string in
            self.requestPokemonList.onNext(())
        }).disposed(by: disposeBag)
    }
}

extension PokemonViewModel: Stepper {
    public func navigateToPokemonDetail(id: String) {
        steps.accept(AppStep.pokemonDetail(id: id))
    }
}
