//
//  NetworkSuccess.swift
//  SharedPips
//
//  Created by Ethan Pippin on 6/5/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation

public struct NetworkSuccess {
    public let response: HTTPURLResponse
    public let statusCode: Int
    public let json: JSON
    public let data: Data
}

public enum NetworkError: Error {
    case error
    
    public var errorDescription: String? {
        switch self {
        case .error:
            return self.localizedDescription
        }
    }
}
