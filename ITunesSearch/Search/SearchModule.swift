//
//  SearchModule.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func attachView(_ view: SearchViewControllerProtocol) 
    func loadData(by albumName: String)
}

protocol SearchViewControllerProtocol: AnyObject {
    func showAlbum(models: [AlbumViewModel])
}

struct AlbumViewModel {
    let name: String
    let author: String
    let imageURL: URL?
    let collectionId: String
}
