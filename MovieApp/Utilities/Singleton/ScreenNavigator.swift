//
//  ScreenNavigator.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 6.11.2022.
//

import Foundation
import UIKit

class ScreenNavigator {
    static let shared = ScreenNavigator()
    
    private init() {}
    
    private let sb = UIStoryboard(name: "Main", bundle: nil)
        
    func getMovieScreen() -> MovieViewController?{
        let vc = self.sb.instantiateViewController(withIdentifier: MovieViewController.storyboardId) as? MovieViewController
        if let vc = vc {
            vc.navigationItem.title = "Movie Page"
        }
        
        return vc
    }
    
    func getMovieDetailsScreen(movieUIModel: MovieUIModel?) -> MovieDetailsViewController?{
        guard let movieUIModel = movieUIModel else { return nil }
        let vc = MovieDetailsViewController()
        vc.movieUIModel = movieUIModel
        vc.navigationItem.title = "\(movieUIModel.type.uppercased()) Details"
        return vc
    }
}
