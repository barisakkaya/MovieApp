//
//  CRNotificationView.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import UIKit

class CRNotificationView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.init(white: 1, alpha: 0)
    }
}
