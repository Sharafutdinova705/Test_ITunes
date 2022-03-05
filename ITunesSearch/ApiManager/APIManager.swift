//
//  APIManager.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 05.03.2022.
//

import Foundation

enum RequestType: FinalURLPoint {
    case current(term: String)
    case albumDetail(id: String)
    
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com/")!
    }
    
    var searchPath: String {
        switch self {
        case .current(let term):
            let editedterm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!.lowercased()
            return "search?term=\(editedterm)&media=music&entity=album&limit=100"
        case .albumDetail(let id):
            let editedId = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!.lowercased()
            return "lookup?id=\(editedId)&entity=song"
        }
    }
    
    var request: URLRequest {
        if let url = URL(string: baseURL.absoluteString + searchPath) {
            return URLRequest(url: url)
        } else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
    }
}

class APIManager: APIManagerProtocol {
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    func fetchResultWith(term: String, completionHandler: @escaping (APIResult<FoundedItem>) -> Void) {
        
        let request = RequestType.current(term: term).request
        
        fetch(request: request, parse: { (json) -> [FoundedItem]? in
            if let dictionary = json[AllConstants.results] as? [[String: AnyObject]] {
                var founded: [FoundedItem] = []
                for item in dictionary {
                    if let foundedJson = FoundedItem(JSON: (item)) {
                        founded.append(foundedJson)
                    }
                }
                return founded
            } else {
                return nil
            }
        }, completionHandler: completionHandler)
    }
    
    func fetchAlbumDetailResultWith(id: String, completionHandler: @escaping (APIResult<AlbumDetailFoundedItem>) -> Void) {
        
        let request = RequestType.albumDetail(id: id).request
        
        fetch(request: request, parse: { (json) -> [AlbumDetailFoundedItem]? in
            if let dictionary = json[AllConstants.results] as? [[String: AnyObject]] {
                var founded: [AlbumDetailFoundedItem] = []
                for item in dictionary {
                    if let foundedJson = AlbumDetailFoundedItem(JSON: (item)) {
                        founded.append(foundedJson)
                    }
                }
                return founded
            } else {
                return nil
            }
        }, completionHandler: completionHandler)
    }
}
