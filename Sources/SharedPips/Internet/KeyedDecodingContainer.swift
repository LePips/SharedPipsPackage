//
//  KeyedDecodingContainer.swift
//  SharedPips
//
//  Created by Ethan Pippin on 3/14/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode<T: Decodable>(for key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}
