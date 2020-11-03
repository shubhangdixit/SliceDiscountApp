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
