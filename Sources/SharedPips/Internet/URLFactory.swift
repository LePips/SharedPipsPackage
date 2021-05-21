//
//  URLFactory.swift
//  SharedPips
//
//  Created by Ethan Pippin on 3/14/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import Foundation

extension URL {
    static func build(with base: URL, paths: [String]) -> URL {
        var url = base
        paths.forEach({ url.appendPathComponent($0) })
        return url
    }
}
