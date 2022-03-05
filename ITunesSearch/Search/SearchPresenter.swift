//
//  SearchPresenter.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewControllerProtocol?
    lazy var apiManager = APIManager(sessionConfiguration: URLSessionConfiguration.default)
    
    func attachView(_ view: SearchViewControllerProtocol) {
        self.view = view
    }
    
    func loadData(by albumName: String) {
        apiManager.fetchResultWith(term: albumName) { (result) in
            switch result {
            case .success(let foundedItems):
                var models: [AlbumViewModel] = []
                for item in foundedItems {
                    models.append(AlbumViewModel(name: item.collectionName, author: item.artistName, imageURL: URL(string: item.artworkUrl60), collectionId: item.collectionId))
                }
                self.view?.showAlbum(models: models)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
