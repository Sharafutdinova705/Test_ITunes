//
//  SearchCollectionViewCell.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import UIKit


class SearchCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlets
    @IBOutlet private var cellImageView: UIImageView!
    @IBOutlet private var cellTitle: UILabel!
    @IBOutlet private var cellSubtitle: UILabel!
    
    // MARK: Properties
    private var model: AlbumViewModel?
    
    private func setupData() {
        if let imageURL = model?.imageURL {
            cellImageView.sd_setImage(with: imageURL, completed: nil)
        }
        cellTitle.text = model?.name
        cellSubtitle.text = model?.author
    }
    
    func configure(model: AlbumViewModel) {
        self.model = model
        setupData()
    }
}
