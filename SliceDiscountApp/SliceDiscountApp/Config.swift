//
//  Config.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import Foundation
import UIKit

let shouldUseOfflineData = true
let offlineDiscountListFile = "AppData.json"

struct HomeScreenValues {
    let cellSpacingHeight : CGFloat = 15
    let topViewCornerRadius : CGFloat = 15
    let topViewMessage : String = "hi there!"
    let cardsCornerRadius : CGFloat = 12
    let discountLabelCornerRadius : CGFloat = 8.73
    let brandImageCornerRadius : CGFloat = 5
    let gradientColors : [CGColor] = [UIColor(displayP3Red: 234/255, green: 237/255, blue: 240/255, alpha: 1).cgColor, UIColor(displayP3Red: 209/255, green: 212/255, blue: 227/255, alpha: 1).cgColor]
}

struct PromoDetailScreenValues {
    let topViewCornerRadius : CGFloat = 15
    let brandImageCornerRadius : CGFloat = 7
    let gradientColors : [CGColor] = [UIColor(displayP3Red: 17/255, green: 9/255, blue: 47/255, alpha: 1).cgColor, UIColor.clear.cgColor, UIColor(displayP3Red: 32/255, green: 21/255, blue: 69/255, alpha: 1).cgColor]
    let gradientLocations : [NSNumber] = [0, 0.65, 1]
    let defaultShareMessage = "Hey, I am buying food using slice!."
    let copyMessage = "Code copied"
}
