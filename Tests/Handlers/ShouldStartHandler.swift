//
//  ShouldStartHandler.swift
//  Tests
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import XCTest
import RequestExecutor

class ShouldStartHandler: XCTestCase {
    
    var provider: NetworkingProvider!
    
    override func setUp() {
        provider = TestsProvider(result: .success(true))
    }
    
    func testHandler() {
        let handler = TestHandler()
        RequestExecutor(provider: provider, handlers: [handler]).execute()
        XCTAssert(handler.result)
    }
    
}

private class TestHandler: Handler {
    
    var result = true
    
    func shouldStart(_ executor: RequestExecutor) -> Bool {
        return false
    }
    
    func success(_ executor: RequestExecutor, result: Any?) {
        self.result = false
    }
    
}
