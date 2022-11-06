//
//  MovieManager.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import Foundation

protocol MovieManagerDelegate {
    func didFailWithError(error: Error)
    func didFailFindMovie()
    func didSuccess(movies: [MovieUIModel])
}

class MovieManager {
    
    var delegate: MovieManagerDelegate?
            
    func fetchMovie(title: String) {
        let urlString = "\(NetworkingConstants.movieURL)&s=\(title)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                if let error = error {
                    strongSelf.delegate?.didFailWithError(error: error)
                    return
                }
                else if let data = data {
                    if let movies = strongSelf.parseJSON(data) {
                        strongSelf.delegate?.didSuccess(movies: movies)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> [MovieUIModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Movie.self, from: movieData)
            guard decodedData.response == "True" else {
                delegate?.didFailFindMovie()
                return nil
            }
            var movies: [MovieUIModel] = []
            for data in decodedData.search ?? [] {
                let uiModel = MovieUIModel(title: data.title, year: data.year, imdbID: data.imdbID, type: data.type, poster: data.poster)
                movies.append(uiModel)
            }
            return movies
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
