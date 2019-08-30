//
//  ItemNetwork.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxSwift

final class ItemNetwork {
    
    private let network: Network
    
    init() {
        self.network = Network()
    }
    
    public func searchItems(_ name: String) -> Observable<Result<ItemList, AppError>> {
        return network.performRequest(route: APIRouter.searchItems(name: name))
    }
    
    public func itemDetail(_ name: String) -> Observable<Result<Item, AppError>> {
        return network.performRequest(route: APIRouter.itemDetail(name: name))
    }
    
}
