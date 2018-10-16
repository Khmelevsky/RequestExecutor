//
//  ProgressHandler.swift
//  Tests
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import XCTest
import RequestExecutor

private let result: [Progress] = [Progress(totalUnitCount: 1), Progress(totalUnitCount: 50), Progress(totalUnitCount: 100)]

class ProgressHandler: XCTestCase {
    
    var provider: NetworkingProvider!
    
    override func setUp() {
        provider = TestsProvider(result: .progressSuccess(result, success: true))
    }
    
    func testHandler() {
        let handler = TestHandler()
        let executor = RequestExecutor(provider: provider, handlers: [handler])
        executor.execute()
        XCTAssertEqual(result, handler.progress)
        XCTAssert(handler.result)
    }
    
}

private class TestHandler: Handler {
    
    var progress = [Progress]()
    var result = false
    
    func progress(_ executor: RequestExecutor, progress: Progress) {
        self.progress.append(progress)
    }
    
    func success(_ executor: RequestExecutor, result: Any?) {
        guard let result = result as? Bool else { return }
        self.result = result
    }
}
