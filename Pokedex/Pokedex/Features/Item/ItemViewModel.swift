//
//  ItemViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class ItemViewModel: ServicesViewModel {
    typealias Services = ItemServices
    var services: Services!
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    public let requestItemList: AnyObserver<Void>
    public var itemList: Observable<Result<ItemList, AppError>> {
        return itemListSubject.asObservable()
    }
    
    private let itemListSubject = PublishSubject<Result<ItemList, AppError>>()
    var searchText = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    init() {
        let _requestItemList = PublishSubject<Void>()
        self.requestItemList = _requestItemList.asObserver()
        _requestItemList
            .flatMap { [unowned self] _ -> Observable<Result<ItemList, AppError>> in
                return self.services.itemNetwork.searchItems(self.searchText.value)
            }.bind(to: itemListSubject)
            .disposed(by: disposeBag)
        
        searchText
            .skip(1)
            .throttle(0.5, latest: true, scheduler: MainScheduler.instance)
            .asObservable().subscribe(onNext: { string in
                self.requestItemList.onNext(())
            }).disposed(by: disposeBag)
    }
    
}

extension ItemViewModel: Stepper {
    public func navigateToItemDetail(withItemName name: String) {
        steps.accept(AppStep.itemDetail(name: name))
    }
}
