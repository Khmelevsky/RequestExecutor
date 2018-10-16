//
//  Handler.swift
//  RequestExecutor
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import Foundation

public protocol Handler {
    func shouldStart(_ executor: RequestExecutor) -> Bool
    
    // start
    func willStart(_ executor: RequestExecutor) -> Error?
    func didStart(_ executor: RequestExecutor)
    
    // progress
    func progress(_ executor: RequestExecutor, progress: Progress)
    
    // finish
    func willFinish(_ executor: RequestExecutor)
    func prepareSuccess(_ executor: RequestExecutor, result: Any?) -> Error?
    func prepareFailure(_ executor: RequestExecutor, error: Error) -> Error
    func didFinish(_ executor: RequestExecutor)
    
    func success(_ executor: RequestExecutor, result: Any?)
    func failure(_ executor: RequestExecutor, error: Error)
}

public extension Handler {
    func shouldStart(_ executor: RequestExecutor) -> Bool { return true }
    
    // start
    func willStart(_ executor: RequestExecutor) -> Error? { return nil }
    func didStart(_ executor: RequestExecutor) {}
    
    // progress
    func progress(_ executor: RequestExecutor, progress: Progress) {}
    
    // finish
    func willFinish(_ executor: RequestExecutor) {}
    func prepareSuccess(_ executor: RequestExecutor, result: Any?) -> Error? { return nil }
    func prepareFailure(_ executor: RequestExecutor, error: Error) -> Error { return error }
    func didFinish(_ executor: RequestExecutor) {}
    
    func success(_ executor: RequestExecutor, result: Any?) {}
    func failure(_ executor: RequestExecutor, error: Error) {}
}
