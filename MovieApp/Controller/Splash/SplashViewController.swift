//
//  ViewController.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 31.10.2022.
//

import UIKit

class SplashViewController: UIViewController, NotificationViewDelegate {
    var notificationView: CRNotificationView!
    
    @IBOutlet private weak var loodosLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var labelText: String = "" {
        didSet {
            updateUI(text: labelText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        startAnimating()
    }
    
    private func configure() {
        RCManager.shared.delegate = self
        configureLayout()
        checkInternetStatus()
    }
    
    private func configureLayout() {
        loodosLabel.text = ""
        
        notificationView = CRNotificationView()
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationView)
        
        notificationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    private func navigateViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            RCManager.shared.delegate = nil
            guard let vc = ScreenNavigator.shared.getMovieScreen() else { return }
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    private func checkInternetStatus() {
        if Connectivity.isConnectedToInternet {
             RCManager.shared.fetchCloudValues()
         } else {
             showBannerInNotificationView(text: "You have no internet connection. We'll check again 5 seconds later.")
             DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                 self.checkInternetStatus()
             }
        }
    }
        
    private func updateUI(text: String) {
        loodosLabel.text = text
    }
    
}


extension SplashViewController: RCManagerDelegate {
    func didCompleteFetch() {
        DispatchQueue.main.async {
            self.labelText = RCManager.shared.getLoodosSplashText
            self.activityIndicator.stopAnimating()
        }
        navigateViewController()
    }
}
