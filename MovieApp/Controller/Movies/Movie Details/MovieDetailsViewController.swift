//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 6.11.2022.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var imdbLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var movieUIModel: MovieUIModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        guard let movieUIModel = movieUIModel else { return }
        
        let url = URL(string: movieUIModel.poster)
        posterImageView.kf.setImage(with: url)
        
        typeLabel.text = "Type: \(movieUIModel.type)"
        yearLabel.text = "Year: \(movieUIModel.year)"
        imdbLabel.text = "IMDB id: \(movieUIModel.imdbID)"
        nameLabel.text = movieUIModel.title
    }

}
