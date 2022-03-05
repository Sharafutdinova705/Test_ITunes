//
//  APIManagerProtocol.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 05.03.2022.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONcompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

protocol FinalURLPoint {
    var baseURL: URL { get }
    var searchPath: String { get }
    var request: URLRequest { get }
}

enum APIResult<T> {
    case success([T])
    case failure(Error)
}

protocol APIManagerProtocol {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONcompletionHandler) -> JSONTask
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> [T]?, completionHandler: @escaping (APIResult<T>) -> Void)
}

extension APIManagerProtocol {
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONcompletionHandler) -> JSONTask {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let HTTPResponse = response as? HTTPURLResponse else { return }
            if data == nil {
                if let error = error {
                    completionHandler(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                        completionHandler(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completionHandler(nil, HTTPResponse, error)
                    }
                default:
                    print("Response status : \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> [T]?, completionHandler: @escaping (APIResult<T>) -> Void) {
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
            DispatchQueue.main.async(execute: {
                guard let json = json else {
                    if let error = error {
                        completionHandler(.failure(error))
                    }
                    return
                }
                if let value = parse(json) {
                    completionHandler(.success(value))
                } else {
                    return
                }
            })
        }
        dataTask.resume()
    }
}

