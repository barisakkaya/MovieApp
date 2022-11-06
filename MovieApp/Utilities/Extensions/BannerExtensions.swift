//
//  BannerExtensions.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 5.11.2022.
//

import UIKit
import BRYXBanner

extension UIViewController {
    func showBanner(view: UIView, text: String, color: UIColor, bannerPosition: BannerPosition? = .top) {
        let banner = Banner(title: text,
                            subtitle: nil,
                            image: nil,
                            backgroundColor: color,
                            didTapBlock: nil)
        banner.springiness = .heavy
        banner.animationDuration = 1
        banner.position = bannerPosition ?? .top
        banner.show(view, duration: 2)
    }
}

protocol NotificationViewDelegate: UIViewController {
    var notificationView: CRNotificationView! { get }
}

extension NotificationViewDelegate {
    func showBannerInNotificationView(text: String, color: UIColor = UIColor.bannerColor) {
        guard let notifView = self.notificationView else { return }
        view?.bringSubviewToFront(notifView)
        showBanner(view: notifView, text: text, color: color)
    }
    
    func showInternalErrorBanner() {
        showBannerInNotificationView(text: "Something went wrong, please try again.")
    }
}
