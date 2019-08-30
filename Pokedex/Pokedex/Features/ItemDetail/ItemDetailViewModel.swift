//
//  ItemDetailViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift

class ItemDetailViewModel: ServicesViewModel {
    typealias Services = ItemServices
    public var services: Services!
    public var steps: PublishRelay<Step> = PublishRelay<Step>()
    public let requestItemDetail: AnyObserver<Void>
    public var itemDetail: Observable<Result<Item, AppError>> {
        return itemDetailSubject.asObservable()
    }
    
    private let itemDetailSubject = PublishSubject<Result<Item, AppError>>()
    private let disposeBag = DisposeBag()
    
    init(itemName: String) {
        let _requestItemDetail = PublishSubject<Void>()
        self.requestItemDetail = _requestItemDetail.asObserver()
        _requestItemDetail
            .flatMap { [unowned self] _ -> Observable<Result<Item, AppError>> in
                return self.services.itemNetwork.itemDetail(itemName)
            }.bind(to: itemDetailSubject)
            .disposed(by: disposeBag)
    }
}

extension ItemDetailViewModel: Stepper {
    
}
