//
//  SharedExtensions.swift
//  MovieApp
//
//  Created by Barış Can Akkaya on 6.11.2022.
//

import Foundation
import UIKit

extension Int {
    var stringValue: String {
        return String(self)
    }
}

extension UIView {
    
    static let defaultCornerRadius: CGFloat = 12
    
    func addVerticalSpacingConstraint(bottomView: UIView, topView: UIView, spacing: CGFloat) {
        let constraint = NSLayoutConstraint(item: bottomView,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: topView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: spacing)
        constraint.isActive = true
        addConstraint(constraint)
    }
    
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

extension UITextField {
    var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}

extension UIButton {
    
    func setText(text: String) {
        setTitle(text, for: .normal)
    }
    
    private static let activityIndicatorTag = 13371337
    
    func showLoadingIndicator(color: UIColor, isArrowButton: Bool = true) {
        let indicator = UIActivityIndicatorView()
        var buttonHeight: CGFloat = bounds.height
        var buttonWidth = bounds.width
        indicator.tag = UIButton.activityIndicatorTag
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = color
        self.addSubview(indicator)
        if isArrowButton {
            buttonHeight = 50
            buttonWidth = UIScreen.main.bounds.width
            indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        } else {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            if buttonHeight < 50 {
                indicator.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
            }
        }
        indicator.startAnimating()
    }
    
    func removeLoadingIndicator() {
        guard let indicator = self.viewWithTag(UIButton.activityIndicatorTag) as? UIActivityIndicatorView else { return }
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    func setTitleWithoutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)
        
        setTitle(title, for: .normal)
        
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
    
    func localizeTitle() {
        setTitleWithoutAnimation(title: title(for: .normal))
    }
}


extension UIViewController {
    
    /// This method can be called in any controller's viewDidLoad to hide keyboard
    /// when tapped outside of it.
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

protocol SettingPresentable: UIViewController {
    func promptToSettings()
}

extension Dictionary where Key == String {
    var alphabeticallySortedKeys: [String] {
        return keys.sorted()
    }
}

extension Array {
    func subarrayUsingGivenIndices(_ indices: Set<Int>) -> Array {
        var newArray = Array<Element>()
        for i in indices {
            newArray.append(self[i])
        }
        return newArray
    }
    
    var lastIndex: Int {
        return count - 1
    }
}


//MARK:- IBInspectable
extension UIView {
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
