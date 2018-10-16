//
//  ExecutorControl.swift
//  RequestExecutor
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import Foundation

public protocol ExecutorControl {
    func requestDidSuccess(result: Any?)
    func requestDidFailure(error: Error)
    func requestDidUpdateProgress(progress: Progress)
}
