//
//  MoveNetwork.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import RxSwift

final class MoveNetwork {
    
    private let network: Network
    
    init() {
        self.network = Network()
    }
    
    public func searchMoves(_ name: String) -> Observable<Result<MoveList, AppError>> {
        return network.performRequest(route: APIRouter.searchMoves(name: name))
    }
    
    public func moveDetail(_ name: String) -> Observable<Result<Move, AppError>> {
        return network.performRequest(route: APIRouter.moveDetail(name: name))
    }
    
}
