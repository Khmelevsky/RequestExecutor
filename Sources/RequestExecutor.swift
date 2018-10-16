//
//  RequestExecutor.swift
//  RequestExecutor
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import Foundation

open class RequestExecutor {
    
    public let provider: NetworkingProvider
    open var handlers: [Handler]
    
    public init(provider: NetworkingProvider, handlers: [Handler] = []) {
        self.provider = provider
        self.handlers = handlers
    }
    
    open func execute() {
        guard self.handlers.filter({ $0.shouldStart(self) == false }).count == 0 else {
            return
        }
        for handler in self.handlers {
            if let error = handler.willStart(self) {
                self.requestDidComplete(result: .error(error))
                return
            }
        }
        self.provider.executeRequest(with: self)
        self.handlers.forEach({ $0.didStart(self) })
    }
    
}

extension RequestExecutor: ExecutorControl {
    
    fileprivate enum RequestResult {
        case success(Any?)
        case error(Error)
    }
    
    fileprivate func requestDidComplete(result: RequestResult) {
        switch result {
        case .error(var error):
            for handler in self.handlers {
                error = handler.prepareFailure(self, error: error)
            }
            self.handlers.forEach({ $0.failure(self, error: error) })
        case .success(let result):
            self.handlers.forEach({ $0.success(self, result: result) })
        }
        self.handlers.forEach({ $0.didFinish(self) })
    }
    
    public func requestDidSuccess(result: Any?) {
        self.handlers.forEach({ $0.willFinish(self) })
        var error: Error?
        for handler in self.handlers {
            if let prepareError = handler.prepareSuccess(self, result: result) {
                error = prepareError
                break
            }
        }
        if let error = error {
            self.requestDidComplete(result: .error(error))
        } else {
            self.requestDidComplete(result: .success(result))
        }
    }
    
    public func requestDidFailure(error: Error) {
        self.handlers.forEach({ $0.willFinish(self) })
        self.requestDidComplete(result: .error(error))
    }
    
    public func requestDidUpdateProgress(progress: Progress) {
        self.handlers.forEach({ $0.progress(self, progress: progress) })
    }
    
}
