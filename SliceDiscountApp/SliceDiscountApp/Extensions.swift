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
