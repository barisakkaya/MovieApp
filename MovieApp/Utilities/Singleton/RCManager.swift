//
//  RCManager.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 4.11.2022.
//

import Foundation
import FirebaseRemoteConfig

class RCManager {
    
    static let shared = RCManager()
    var delegate: RCManagerDelegate?
    
    private init() {}
    
    enum Key: String {
        case loodosSplashText
    }
    
    lazy var getLoodosSplashText: String = {
        let variable = RCManager.shared.variable(name: RCManager.Key.loodosSplashText.rawValue) ?? "Loodos"
        return variable
    }()
    
    
    func variable(name: String) -> String? {
        guard let val = RemoteConfig.remoteConfig()[name].stringValue else {
            return nil
        }
        
        guard !val.isEmpty else {
            return nil
        }
        
        return val
    }
    
    func variableData(name: String) -> Data {
        return RemoteConfig.remoteConfig()[name].dataValue
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() {
        // 1
        activateDebugMode()
        
        // 2
        RemoteConfig.remoteConfig().fetch { [weak self] _, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                // In a real app, you would probably want to call the loading
                // done callback anyway, and just proceed with the default values.
                // I won't do that here, so we can call attention
                // to the fact that Remote Config isn't loading.
                return
            }
            
            // 3
            RemoteConfig.remoteConfig().activate { _, _ in
                strongSelf.delegate?.didCompleteFetch()
            }
        }
    }
}

protocol RCManagerDelegate: AnyObject {
    func didCompleteFetch()
}
