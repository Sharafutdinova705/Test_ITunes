//
//  ResultInfoTableViewCell.swift
//  ITunesSearch
//
//  Created by Гузель Шарафутдинова on 04.03.2022.
//

import UIKit
import SDWebImage

class ResultInfoTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: Properties
    private var model: AlbumViewModel?
    
    private func setupData() {
        if let imageURL = model?.imageURL {
            resultImageView.sd_setImage(with: imageURL, completed: nil)
        }
        titleLabel.text = model?.name
        subtitleLabel.text = model?.author
    }
    
    func configure(model: AlbumViewModel) {
        self.model = model
        setupData()
    }
}
