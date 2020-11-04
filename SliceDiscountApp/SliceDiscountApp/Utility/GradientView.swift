//
//  GradientView.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 04/11/20.
//

import Foundation
import UIKit

class GradientView: UIView {

    private let gradient : CAGradientLayer = CAGradientLayer()

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    public func drawGradients(forColors colors : [CGColor], andLocations locations : [NSNumber] = []) {
        gradient.frame = self.bounds
        gradient.colors = colors
        if locations.count == colors.count {
            gradient.locations = locations
        }
        layer.insertSublayer(gradient, at: 0)
    }
}
