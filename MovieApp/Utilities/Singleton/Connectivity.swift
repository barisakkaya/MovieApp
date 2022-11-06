//
//  Connectivity.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
