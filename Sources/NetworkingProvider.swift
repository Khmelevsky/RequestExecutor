//
//  NetworkingProvider.swift
//  RequestExecutor
//
//  Created by Alexander Khmelevsky on 16/10/2018.
//  Copyright © 2018 Alexander Khmelevsky. All rights reserved.
//

import Foundation

public protocol NetworkingProvider {
    func executeRequest(with control: ExecutorControl)
}
