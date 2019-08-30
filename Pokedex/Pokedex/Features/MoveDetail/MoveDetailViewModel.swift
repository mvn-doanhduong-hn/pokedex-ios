//
//  MoveDetailViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift

class MoveDetailViewModel: ServicesViewModel {
    typealias Services = MoveServices
    public var services: Services!
    public var steps: PublishRelay<Step> = PublishRelay<Step>()
    public let requestMoveDetail: AnyObserver<Void>
    public var moveDetail: Observable<Result<Move, AppError>> {
        return moveDetailSubject.asObservable()
    }
    
    private let moveDetailSubject = PublishSubject<Result<Move, AppError>>()
    private let disposeBag = DisposeBag()
    
    init(withItemName name: String) {
        let _requestMoveDetail = PublishSubject<Void>()
        self.requestMoveDetail = _requestMoveDetail.asObserver()
        _requestMoveDetail
            .flatMap { [unowned self] _ -> Observable<Result<Move, AppError>> in
                return self.services.moveNetwork.moveDetail(name)
            }.bind(to: moveDetailSubject)
            .disposed(by: disposeBag)
    }
}

extension MoveDetailViewModel: Stepper {
    
}
