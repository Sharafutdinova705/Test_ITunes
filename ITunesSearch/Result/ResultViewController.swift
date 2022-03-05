//
//  ResultViewController.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import UIKit

class ResultViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Constants
    private enum Constants {
        static let cellIdentifier = "ResultInfoTableViewCell"
        static let firstCellHeight: CGFloat = 180
        static let defauldCellHeight: CGFloat = 44
    }
    
    // MARK: Properties
    private var model: AlbumViewModel?
    private var songNames: AlbumDetailViewModel?
    private let resultPresenter: ResultPresenterProtocol = ResultPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        resultPresenter.attachView(self)
        title = model?.name
        if let model = model {
            resultPresenter.loadData(by: model)
        }
    }
    
    func configure(model: AlbumViewModel) {
        self.model = model
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (songNames?.songNames.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ResultInfoTableViewCell, indexPath.row == 0 {
            if let model = model {
                cell.configure(model: model)
            }
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = songNames?.songNames[indexPath.row-1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return Constants.firstCellHeight
        } else {
            return Constants.defauldCellHeight
        }
    }
}

extension ResultViewController: ResultViewControllerProtocol {
    func showAlbum(models: AlbumDetailViewModel) {
        songNames = models
        tableView.reloadData()
    }
}
