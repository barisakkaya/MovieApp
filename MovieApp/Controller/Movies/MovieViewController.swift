//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import UIKit

class MovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureNavBar()
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
    }
    
    private func configureNavBar() {
        self.navigationItem.title = "Movie Page"
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

}
