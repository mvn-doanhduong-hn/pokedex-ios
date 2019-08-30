//
//  NetworkManager.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import Alamofire

let sessionManager: SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = APIConstant.DEFAULT_TIMEOUT_INTERVAL
    let sessionManager = SessionManager(configuration: configuration)
    let oAuthHandler = OAuthHandler()
    sessionManager.adapter = oAuthHandler
    sessionManager.retrier = oAuthHandler
    return sessionManager
}()

class OAuthHandler: RequestAdapter, RequestRetrier {
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ idToken: String?) -> Void
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    //    private let tokenService = TokenManagementService()
    //    private var oauthswiftClient: OAuth2Swift?
    
    // MARK: - Initialization
    
    public init() {
        
    }
    
    // MARK: - RequestAdapter
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let urlRequest = urlRequest
        
        //TODO: Attach saved auth token with URLRequest from  here
        
        //        if let idToken = tokenService.getIdToken() {
        //            urlRequest.setValue("Bearer " + idToken, forHTTPHeaderField: "Authorization")
        //        }
        
        return urlRequest
    }
    
    // MARK: - RequestRetrier
    
    func should(_ manager: Alamofire.SessionManager,
                retry request: Alamofire.Request,
                with error: Swift.Error,
                completion: @escaping Alamofire.RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == HTTPStatusCodes.Unauthorized.rawValue {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, idToken in
                    
                    self?.lock.lock() ; defer { self?.lock.unlock() }
                    
//                    if let idToken = idToken {
//                        //TODO: Store token here
//                    }
                    
                    self?.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    self?.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        //TODO: Manage refresh token here
    }
}
