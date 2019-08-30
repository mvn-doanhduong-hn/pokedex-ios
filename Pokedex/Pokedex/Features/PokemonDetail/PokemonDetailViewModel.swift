//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift

class PokemonDetailViewModel: ServicesViewModel {
    typealias Services = PokemonServices
    public var services: Services!
    public var steps: PublishRelay<Step> = PublishRelay<Step>()
    public let requestPokemonDetail: AnyObserver<Void>
    public var pokemonDetail: Observable<Result<PokemonDetail, AppError>> {
        return pokemonDetailSubject.asObservable()
    }
    
    private let pokemonDetailSubject = PublishSubject<Result<PokemonDetail, AppError>>()
    private let disposeBag = DisposeBag()
    
    init(withPokemonId id: String) {
        let _requestPokemonDetail = PublishSubject<Void>()
        self.requestPokemonDetail = _requestPokemonDetail.asObserver()
        _requestPokemonDetail
            .flatMap { [unowned self] _ -> Observable<Result<PokemonDetail, AppError>> in
                return self.services.pokemonNetwork.pokemonDetail(id)
            }.bind(to: pokemonDetailSubject)
            .disposed(by: disposeBag)
    }
}

extension PokemonDetailViewModel: Stepper {
    
}
