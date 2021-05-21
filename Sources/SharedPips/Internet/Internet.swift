//
//  Internet.swift
//  PipsStuff
//
//  Created by Ethan Pippin on 2/13/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import Dispatch

public typealias JSON = [String: Any]
public typealias Parameters = [String: Any]
public typealias Headers = [String: String]
public typealias NetworkResponse = Result<NetworkSuccess, NetworkError>

public enum NetworkMethodType: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct Internet { }

// MARK: - Methods
extension Internet {
    public static func request(_ method: NetworkMethodType = .get, url: URL, parameters: Parameters? = nil, headers: Headers? = nil, body: Data? = nil, completion: @escaping (NetworkResponse) -> Void) {
        let request = setupRequest(url, parameters: parameters, headers: headers, body: body, method: method.rawValue)
        sendRequest(request, completion: completion)
    }
}

// MARK: - Processing and Helpers
extension Internet {
    
    private static func setupRequest(_ url: URL, parameters: Parameters? = nil, headers: Headers? = nil, body: Data? = nil, method: String) -> URLRequest {
        let urlString = url.absoluteString
        var url = URLComponents(string: urlString)!
        
        // Add parameters
        if let parameters = parameters {
            for (key, value) in parameters {
                let stringValue = String(describing: value)
                url.queryItems?.append(URLQueryItem(name: key, value: stringValue))
            }
        }
        
        // Create request
        var request = URLRequest(url: url.url!)
        // Add headers
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        request.httpBody = body
        
        return request
    }
    
    private static func sendRequest(_ request: URLRequest, completion: @escaping (NetworkResponse) -> Void) {
        let debug = NetworkDebug(url: request.url!.absoluteString)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            process(data, response, error, debug, completion)
        }.resume()
    }

    private static func process(_ data: Data?, _ response: URLResponse?, _ error: Error?, _ debug: NetworkDebug, _ completion: @escaping (NetworkResponse) -> Void) {
        var debug = debug

        if let _ = error {
            completion(NetworkResponse.failure(NetworkError.error))
        } else if let status = response as? HTTPURLResponse {
            let statusCode = status.statusCode
            debug.statusCode = String(describing: statusCode)
            
            let json: JSON = buildJSON(from: data)
            
            let success = NetworkSuccess(response: status, statusCode: statusCode, json: json, data: data ?? Data())
            completion(.success(success))
        } else {
            completion(.failure(.error))
        }
        debug.log()
    }

    private static func buildJSON(from data: Data?) -> JSON {
        guard let data = data else { return [:] }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON else {
                return [:]
            }
            return json
        } catch {
            return [:]
        }
    }
}

struct NetworkDebug {
    var url: String
    var statusCode: String
    
    init(url: String) {
        self.url = url
        self.statusCode = ""
    }
    
    func log() {
        
    }
}
