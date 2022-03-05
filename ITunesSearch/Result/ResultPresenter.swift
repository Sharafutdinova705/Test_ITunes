//
//  ResultPresenter.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import Foundation

class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewControllerProtocol?
    lazy var apiManager = APIManager(sessionConfiguration: URLSessionConfiguration.default)
    
    func attachView(_ view: ResultViewControllerProtocol) {
        self.view = view
    }
    
    func loadData(by model: AlbumViewModel) {
        apiManager.fetchAlbumDetailResultWith(id: model.collectionId) { result in
            switch result {
            case .success(let models):
                var names: [String] = []
                for model in models {
                    if model.trackName != AllConstants.empty {
                        names.append(model.trackName)
                    }
                }
                self.view?.showAlbum(models: AlbumDetailViewModel(name: model.name, author: model.author, songNames: names))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
