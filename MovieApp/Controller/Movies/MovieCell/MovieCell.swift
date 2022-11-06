//
//  MovieCell.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 6.11.2022.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(movieUIModel: MovieUIModel?) {        
        guard let movieUIModel = movieUIModel else { return }
        
        movieLabel.text = movieUIModel.title
        
        let url = URL(string: movieUIModel.poster)
        movieImageView.kf.setImage(with: url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
