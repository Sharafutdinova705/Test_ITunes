//
//  ResultModule.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import Foundation

protocol ResultPresenterProtocol: AnyObject {
    func attachView(_ view: ResultViewControllerProtocol)
    func loadData(by model: AlbumViewModel)
}

protocol ResultViewControllerProtocol: AnyObject {
    func showAlbum(models: AlbumDetailViewModel)
}

struct AlbumDetailViewModel {
    let name: String
    let author: String
    let songNames: [String]
}
