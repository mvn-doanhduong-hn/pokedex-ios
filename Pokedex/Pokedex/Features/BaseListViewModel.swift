//
//  BaseListViewModel.swift
//  Pokedex
//
//  Created by LTT on 8/30/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class BaseListViewModel: ServicesViewModel {
    typealias Services = HomeService
    
    var services: Services!
    
    public let requestList: AnyObserver<Void>
    let _requestList = PublishSubject<Void>()
    
    var searchText = BehaviorRelay<String>(value: "")
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.requestList = _requestList.asObserver()
        searchText
            .skip(1)
            .throttle(0.5, latest: true, scheduler: MainScheduler.instance)
            .asObservable().subscribe(onNext: { string in
                self.requestList.onNext(())
            }).disposed(by: disposeBag)
    }
}

