//
//  SuccessHandler.swift
//  Tests
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import XCTest
import RequestExecutor

private let result = true

class SuccessHandler: XCTestCase {
    
    var provider: NetworkingProvider!
    
    override func setUp() {
        provider = TestsProvider(result: .success(result))
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
    func success(_ executor: RequestExecutor, result: Any?) {
        guard let result = result as? Bool else { return }
        self.result = result
    }
}
