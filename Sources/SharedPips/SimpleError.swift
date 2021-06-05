//
//  SimpleError.swift
//  
//
//  Created by Ethan Pippin on 5/21/21.
//

import Foundation

public class SimpleError: Error {
    
    private var message: String
    
    public init(_ message: String) {
        self.message = message
    }
    
    var localizedDescription: String {
        return message
    }
}
