//
//  Extensions.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import Foundation
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UIView {
    func setCorners(withRadius radius : CGFloat) {
        layer.cornerRadius = radius
    }
    
    func dropGradients(forColors colors : [CGColor], andLocations locations : [NSNumber] = []) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        if locations.count == colors.count {
            gradient.locations = locations
        }
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addGradientView(withColors colors : [CGColor], andLocations locations : [NSNumber] = []) {
        let subView = UIView(frame: self.bounds)
        self.addSubview(subView)
        subView.backgroundColor = .clear
        subView.dropGradients(forColors: colors, andLocations: locations)
        self.sendSubviewToBack(subView)
    }
}

extension UIViewController {

func showToast(withMessage message : String) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 80, y: self.view.frame.size.height-100, width: 160, height: 40))
    toastLabel.backgroundColor = UIColor.slicePurple()
    toastLabel.textColor = UIColor.white
    toastLabel.font = UIFont(name: "HiraginoSans-W6", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .medium)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 2.5, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

extension UIColor {
    class func slicePurple() -> UIColor {
        return UIColor(displayP3Red: 54/255, green: 49/255, blue: 94/255, alpha: 1)
    }
}

extension UIImage {
    class func image(forText text: String) -> UIImage? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 55, height: 15))
        label.text = text
        label.textColor = .darkGray
        label.font = UIFont(name: "HiraginoSans-W6", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium)
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
