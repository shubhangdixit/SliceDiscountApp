//
//  PromoDetailsViewController.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 04/11/20.
//

import UIKit

class PromoDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var brandImageBackGroundView: UIView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var expireSoonView: UIView!
    
    @IBOutlet weak var promoTitleLabel: UILabel!
    @IBOutlet weak var promoDescriptionLabel: UILabel!
    @IBOutlet weak var promoCodeLabel: UILabel!
    @IBOutlet weak var promoDetailLabel: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var brandImageUIImageView: UIImageView!
    
    var promoIndexPath : PromoIndexPath?
    let promoDetailScreenValues = PromoDetailScreenValues()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIELements()
        setUpGestures()
        loadDataToUI()
    }
    
    func configureUIELements() {
        
        bannerView.setCorners(withRadius: promoDetailScreenValues.topViewCornerRadius)
        bannerView.clipsToBounds = true
        bannerView.layer.masksToBounds = true
        bannerView.addGradientView(withColors: promoDetailScreenValues.gradientColors, andLocations : promoDetailScreenValues.gradientLocations)
        bannerView.sendSubviewToBack(bannerImageView)
        
        brandImageBackGroundView.setCorners(withRadius: promoDetailScreenValues.brandImageCornerRadius)
    }
    
    func loadDataToUI() {
        if let promoIndex = promoIndexPath, let promoData = BusinessManager.shared.discout(forIndex: promoIndex) {
            promoTitleLabel.text = promoData.discountTitle?.uppercased()
            promoDescriptionLabel.text = promoData.discountDesc
            promoCodeLabel.text = promoData.voucherCode
            promoDetailLabel.text = promoData.voucherDesc
            expiryLabel.text = promoData.validTill
            brandImageUIImageView.image = promoData.sellerType.brandLogo(forSeller: promoData.seller)
            bannerImageView.image = promoData.sellerType.brandBanner()
            expireSoonView.isHidden = !(promoData.isExpiringSoon ?? false)
        }
    }
    
    func setUpGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backToTopOffersDidTapped))
        tap.delegate = self
        topHeaderView.addGestureRecognizer(tap)
    }
    
    @IBAction func copyButtonAction(_ sender: Any) {
        if let code = promoCodeLabel.text {
            UIPasteboard.general.string = code
            self.showToast(withMessage: promoDetailScreenValues.copyMessage)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        if let promoIndex = promoIndexPath, let promoData = BusinessManager.shared.discout(forIndex: promoIndex) {
            DispatchQueue.main.async {[weak self] in
                let text = promoData.shareData
                let textShare = [ text ?? self?.promoDetailScreenValues.defaultShareMessage ?? ""] as [Any]
                let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self?.view
                activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
                self?.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func backToTopOffersDidTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isKind(of: UILabel.self) ?? false || touch.view?.isKind(of: UIImageView.self) ?? false {
            return true
        }
        return false
    }
}
