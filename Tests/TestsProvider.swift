//
//  TestsProvider.swift
//  Tests
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import RequestExecutor

class TestsProvider: NetworkingProvider {
    
    enum Result {
        case success(Any)
        case failure(Error)
        case progressSuccess([Progress], success: Any)
        case progressFailure([Progress], failure: Error)
    }
    
    let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    func executeRequest(with control: ExecutorControl) {
        switch result {
        case .success(let result): control.requestDidSuccess(result: result)
        case .failure(let error): control.requestDidFailure(error: error)
        case .progressSuccess(let progress, let success):
            progress.forEach({ control.requestDidUpdateProgress(progress: $0) })
            control.requestDidSuccess(result: success)
        case .progressFailure(let progress, let error):
            progress.forEach({ control.requestDidUpdateProgress(progress: $0) })
            control.requestDidFailure(error: error)
        }
    }
}
