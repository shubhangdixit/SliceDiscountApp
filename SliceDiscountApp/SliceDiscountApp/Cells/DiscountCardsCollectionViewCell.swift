//
//  DiscountCardsCollectionViewCell.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 02/11/20.
//

import UIKit

class DiscountCardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandLogoView: UIView!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    let homeScreenValues = HomeScreenValues()
    
    func setUpCards(withData data : DiscountData) {
        bannerImage.image = data.sellerType.brandBanner()
        brandImage.image = data.sellerType.brandLogo(forSeller: data.seller)
        brandLogoView.setCorners(withRadius: homeScreenValues.brandImageCornerRadius)
        offerView.setCorners(withRadius: homeScreenValues.discountLabelCornerRadius)
        offerLabel.text = data.getDiscount()
    }
}
