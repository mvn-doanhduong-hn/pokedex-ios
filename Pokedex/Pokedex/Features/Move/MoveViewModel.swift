//
//  MoveViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class MoveViewModel: ServicesViewModel {
    typealias Services = MoveServices
    var services: Services!
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    public let requestMoveList: AnyObserver<Void>
    public var moveList: Observable<Result<MoveList, AppError>> {
        return moveListSubject.asObservable()
    }
    
    private let moveListSubject = PublishSubject<Result<MoveList, AppError>>()
    var searchText = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    init() {
        let _requestMoveList = PublishSubject<Void>()
        self.requestMoveList = _requestMoveList.asObserver()
        _requestMoveList
            .flatMap { [unowned self] _ -> Observable<Result<MoveList, AppError>> in
                return self.services.moveNetwork.searchMoves(self.searchText.value)
            }.bind(to: moveListSubject)
            .disposed(by: disposeBag)
        
        searchText
            .skip(1)
            .throttle(0.5, latest: true, scheduler: MainScheduler.instance)
            .asObservable().subscribe(onNext: { string in
                self.requestMoveList.onNext(())
            }).disposed(by: disposeBag)
    }
}

extension MoveViewModel: Stepper {
    public func navigateToMoveDetail(name: String) {
        steps.accept(AppStep.moveDetail(name: name))
    }
}
