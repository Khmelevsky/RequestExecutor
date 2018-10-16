//
//  WillStartHandler.swift
//  Tests
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import XCTest
import RequestExecutor

private enum TestError: Error {
    case failure
}

class WillStartHandler: XCTestCase {
    
    var provider: NetworkingProvider!
    
    override func setUp() {
        provider = TestsProvider(result: .failure(TestError.failure))
    }
    
    func testHandler() {
        let handler = TestHandler()
        let executor = RequestExecutor(provider: provider, handlers: [handler])
        executor.execute()
        XCTAssert(handler.result)
    }
    
}

private class TestHandler: Handler {
    
    var result = false
    
    func willStart(_ executor: RequestExecutor) -> Error? {
        return TestError.failure
    }
    
    func failure(_ executor: RequestExecutor, error: Error) {
        if let error = error as? TestError, error == .failure {
            result = true
        }
    }
}
