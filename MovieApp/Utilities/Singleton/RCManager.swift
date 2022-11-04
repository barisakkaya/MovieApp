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
    private init() { }
    
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

}
