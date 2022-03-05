//
//  Models.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 05.03.2022.
//

import Foundation

struct FoundedItem: Decodable {
    var artistName: String
    var artworkUrl60: String
    var collectionName: String
    var trackViewUrl: String
    var collectionId: String
    
    init(authorLabel: String, artworkUrl60: String, collectionName: String, trackViewUrl: String, collectionId: String) {
        self.artistName = authorLabel
        self.artworkUrl60 = artworkUrl60
        self.collectionName = collectionName
        self.trackViewUrl = trackViewUrl
        self.collectionId = collectionId
    }
}

extension FoundedItem: JSONDecodable {
    init?(JSON: [String:AnyObject]) {
        if let artistName = JSON[AllConstants.artistName] as? String  {
            self.artistName = artistName
        } else {
            self.artistName = AllConstants.empty
        }
        
        if let artworkUrl60 = JSON[AllConstants.artworkUrl60] as? String  {
            self.artworkUrl60 = artworkUrl60
        } else {
            self.artworkUrl60 = AllConstants.empty
        }
        
        if let trackViewUrl = JSON[AllConstants.trackViewUrl] as? String  {
            self.trackViewUrl = trackViewUrl
        } else {
            self.trackViewUrl = AllConstants.empty
        }
        
        if let collectionName = JSON[AllConstants.collectionName] as? String  {
            self.collectionName = collectionName
        } else {
            self.collectionName = AllConstants.empty
        }
        
        if let collectionId = JSON[AllConstants.collectionId] as? Int  {
            self.collectionId = String(collectionId)
        } else {
            self.collectionId = AllConstants.empty
        }
    }
}


enum AllConstants {
    static let artworkUrl60 = "artworkUrl60"
    static let artistName = "artistName"
    static let trackViewUrl = "trackViewUrl"
    static let empty = ""
    static let results = "results"
    static let collectionName = "collectionName"
    static let collectionId = "collectionId"
    static let trackName = "trackName"
}


struct AlbumDetailFoundedItem: Decodable {
    var trackName: String
    
    init(trackName: String) {
        self.trackName = trackName
    }
}

extension AlbumDetailFoundedItem: JSONDecodable {
    init?(JSON: [String:AnyObject]) {
        if let trackName = JSON[AllConstants.trackName] as? String  {
            self.trackName = trackName
        } else {
            self.trackName = AllConstants.empty
        }
    }
}
