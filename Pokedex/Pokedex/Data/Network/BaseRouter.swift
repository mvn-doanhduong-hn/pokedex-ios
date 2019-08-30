//
//  BaseRouter.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRouter: URLRequestConvertible {
    var baseURL: URL? { get }
    var commonPathExtension: String? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var queryStrings: [String: String]? { get }
    var parameters: Parameters? { get }
    var fullURL: URL? { get }
}

extension BaseRouter {
    
    var fullURL: URL? {
        
        guard let _baseURL = baseURL,
            var urlComponents = URLComponents(url: _baseURL, resolvingAgainstBaseURL: false)
            else { return nil }
        
        let _path = (commonPathExtension != nil) ? "\(String(describing: commonPathExtension))\(path)" : "\(path)"
        urlComponents.path = _path
        urlComponents.queryItems = queryStrings?.map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let fullURL = fullURL else { fatalError() }
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        headers?.forEach({ urlRequest.addValue($1, forHTTPHeaderField: $0) })
        
        let doesMethodHasHTTPBody = (method != .get && method != .connect && method != .head && method != .options && method != .trace)
        guard doesMethodHasHTTPBody else { return urlRequest }
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
    
    var headers: HTTPHeaders? {
        let _headers = [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue]
        return _headers
    }
}
