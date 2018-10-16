//
//  EmptyHandler.swift
//  Tests
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import XCTest
import RequestExecutor

class EmptyHandler: XCTestCase {
    
    enum EmptyError: Error {
        case empty
    }
    
    var successProvider: NetworkingProvider!
    var failureProvider: NetworkingProvider!
    
    override func setUp() {
        successProvider = TestsProvider(result: .progressSuccess([Progress(totalUnitCount: 0)], success: true))
        failureProvider = TestsProvider(result: .progressFailure([Progress(totalUnitCount: 0)], failure: EmptyError.empty))
    }
    
    func testHandler() {
        RequestExecutor(provider: successProvider, handlers: [TestHandler()]).execute()
        RequestExecutor(provider: failureProvider, handlers: [TestHandler()]).execute()
    }

}

private class TestHandler: Handler {}
