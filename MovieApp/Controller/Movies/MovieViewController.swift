//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!

    var present: MoviePresenter?
    var movieList: [MovieUIModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    static var storyboardId = "movieViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        present = MoviePresenter(view: self)
        configureNavBar()
        configureLayout()
        searchField.delegate = self
        configureTableView()
        configureTextField()
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
    }
    
    private func configureNavBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = .white
            navBarAppearance.backgroundEffect = nil
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.crystalBlue ]
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.crystalBlue ]
        }
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.reloadData()
    }
    
    private func configureTextField() {
        searchField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        searchField.placeholder = "Search Movie"
        searchField.placeholderColor = .slateGrey
        searchField.tintColor = .slateGrey
        searchField.textColor = .slateGrey
        searchField.cornerRadius = 12
        searchField.borderColor = .slateGrey
        searchField.borderWidth = 1
        searchField.delegate = self
        searchField.backgroundColor = .white
        searchField.setLeftPaddingPoints(12)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        searchField.endEditing(true)
    }

}

extension MovieViewController: MoviePresenterView {
    func showErrorMessage(message: String) {
        print("Error")
    }
    
    func display(newData: [MovieUIModel]) {
        movieList = newData
    }
}

extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter movie"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let title = textField.text {
            present?.fetchData(title: title)
        }
        
        textField.text = ""
        
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieList = movieList else { return 0 }
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UITableViewCell()}
        //guard let previousSearches = previousSearches else { return UITableViewCell() }
        //cell.selectionStyle = .none
        //cell.configureCell(weatherResponse: previousSearches[indexPath.row])
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*guard let previousSearches = previousSearches else { return }
        guard let vc = WeatherScreenNavigator.shared.getWeatherDetailsScreen(weatherResponse: previousSearches[indexPath.row]) else { return }
        navigationController?.pushViewController(vc, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
