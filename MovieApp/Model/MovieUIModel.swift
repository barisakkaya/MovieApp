//
//  MovieUIModel.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 6.11.2022.
//

import Foundation
import Kingfisher

struct MovieUIModel: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    var posterImageView: UIImageView {
        let imageView = UIImageView()
        let url = URL(string: poster)
        imageView.kf.setImage(with: url)
        return imageView
    }
    
}
