//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import Foundation

protocol MoviePresenterView: AnyObject {
    func display(newData: [MovieUIModel])
    func showErrorMessage(message: String)
}

class MoviePresenter {
    var movieManager = MovieManager()
    weak var view: MoviePresenterView?
    
    init(view: MoviePresenterView) {
        self.view = view
        movieManager.delegate = self
    }
    
    func fetchData(title: String) {
        movieManager.fetchMovie(title: title)
    }
}

extension MoviePresenter: MovieManagerDelegate {
    func didFailFindMovie() {
        view?.showErrorMessage(message: "Movie is not found")
    }
    
    func didFailWithError(error: Error) {
        view?.showErrorMessage(message: "Something went wrong!")
    }
    
    func didSuccess(movies: [MovieUIModel]) {
        view?.display(newData: movies)
    }
}
