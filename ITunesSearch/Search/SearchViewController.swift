//
//  SearchViewController.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Constants
    private enum Constants {
        static let searchActionDelay: TimeInterval = 0.5
        static let cellIdentifier = "SearchCollectionViewCell"
        static let storyboardName = "Main"
        static let storyboardNameIdentifier = "Result"
    }
    
    // MARK: Properties
    private var models: [AlbumViewModel]?
    private let searchPresenter: SearchPresenterProtocol = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchPresenter.attachView(self)
    }
    
    @objc private func searchAction() {
        if let text = searchBar.text {
            searchPresenter.loadData(by: text)
        }
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func showAlbum(models: [AlbumViewModel]) {
        self.models = models
        collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let row = models?[indexPath.row],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(model: row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Constants.storyboardNameIdentifier) as? ResultViewController {
            if let model = models?[indexPath.row] {
                vc.configure(model: model)
            }
            navigationController?.show(vc, sender: nil)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(searchAction),
            object: searchBar)
        self.perform(
            #selector(searchAction),
            with: searchBar,
            afterDelay: Constants.searchActionDelay)
    }
}
