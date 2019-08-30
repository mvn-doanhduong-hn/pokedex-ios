//
//  Network.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Alamofire
import RxSwift

final class Network {
    
    private let utilityQueue: DispatchQueue
    let manager: SessionManager
    
    init() {
        self.manager = sessionManager
        self.utilityQueue = DispatchQueue.global(qos: .utility)
    }
    
    func performRequest<T: Decodable>(route: APIRouter) -> Observable<Swift.Result<T, AppError>> {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        return Observable
            .create { [weak self] observer -> Disposable in
                guard let `self` = self else { return Disposables.create {} }
                let request = self.manager.request(route)
                    .validate()
                    .responseData(queue: self.utilityQueue, completionHandler: { [weak self] response in
                        switch response.result {
                        case .success:
                            do {
                                log.debug("Response URl: \(String(describing: response.request) + "\n")")
                                log.debug("Response HTTPHeaderFields: \(String(describing: response.request?.allHTTPHeaderFields) + "\n")")
                                log.debug("Response HTTPURLResponse: \(String(describing: response.response) + "\n")")
                                let model = try response.result.decoded() as T
                                log.debug("Response data: \(model)")
                                observer.onNext(.success(model))
                            } catch {
                                log.debug("JSONSerialization failed")
                                observer.onNext(.failure(error.toAppError(description: error.localizedDescription)))
                            }
                        case .failure(let error):
                            observer.onNext(.failure(error.toAppError(description: error.localizedDescription, errorResponse: response.data)))
                            if let error = error as? AFError {
                                self?.describeError(error)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    })
                log.debug("Request URl: \(String(describing: request))")
                print("Request URl: \(String(describing: request))")
                return Disposables.create {
                    request.cancel()
                }
        }
    }
}

extension Network {
    internal func describeError(_ error: AFError) {
        log.debug("Error code:\(error._code)")
        switch error {
        case .invalidURL(let url):
            log.debug("Invalid URL: \(url) - \(error.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            log.debug("Parameter encoding failed-> Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            log.debug("Multipart encoding failed-> Reason: \(reason)")
        case .responseValidationFailed(let reason):
            log.debug("Response validation failed-> Reason: \(reason)")
        case .responseSerializationFailed(let reason):
            log.debug("Response serialization-> Reason: \(reason)")
        }
        log.debug("Underlying error: \(String(describing: error.underlyingError))")
    }
}
extension Result where Value == Data {
    func decoded<T: Decodable>( using decoder: JSONDecoder = .init() ) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}

extension Result {
    func get() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
