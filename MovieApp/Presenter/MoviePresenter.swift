//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import Foundation

protocol MoviePresenterView: AnyObject {
    func display(newData: String)
}

class MoviePresenter {
    var movieManager = MovieManager()
    weak var view: MoviePresenterView?
    
    init(view: MoviePresenterView) {
        self.view = view
        movieManager.delegate = self
        fetchData()
    }
    
    func fetchData() {
        movieManager.fetchMovie(title: "Avengerszortgame")
    }
}

extension MoviePresenter: MovieManagerDelegate {
    func didFailWithError(error: Error) {
        
    }
    
    func didSuccess(movies: [MovieUIModel]) {
        
    }
}
