//
//  APIRouter.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Alamofire

enum APIRouter: BaseRouter {
    case searchPokemons(name: String)
    case pokemonDetail(id: String)
    
    case searchMoves(name: String)
    case moveDetail(name: String)
    
    case searchItems(name: String)
    case itemDetail(name: String)
    
    var baseURL: URL? {
        return URL(string: ApiPath.baseURLString)
    }
    
    var commonPathExtension: String? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var queryStrings: [String: String]? {
        switch self {
        case .searchPokemons(let name):
            return ["name": name]
        case .searchMoves(let name):
            return ["name": name]
        case .searchItems(let name):
            return ["name": name]
        default:
            return nil
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .searchPokemons(_):
            return "/pokemons"
        case .pokemonDetail(let id):
            return "/pokemons/\(id)"
        case .searchMoves(_):
            return "/moves"
        case .moveDetail(let name):
            return "/moves/\(name)"
        case .searchItems(_):
            return "/items"
        case .itemDetail(let name):
            return "/items/\(name)"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        return nil
    }
    
    private var timestamp: Int? {
        return nil
    }
    
    private var checksum: String? {
        return nil
    }
}
