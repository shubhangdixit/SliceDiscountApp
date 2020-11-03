//
//  Model.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import Foundation

// MARK: - DiscountsModel

enum DecodingError : Error {
    case runtimeError(String)
}


class DiscountsModel : NSObject {
    var data: [[DiscountData]] = [[]]
    
    let dataKey = "data"
    
    init(withDictionary dict : [String : Any]) throws {
        guard let dataArray = dict[dataKey] as? [[[String : Any]]] else {
            throw DecodingError.runtimeError("Invalid Data format")
        }
        for (index, discountsArray) in dataArray.enumerated() {
            for discount in discountsArray {
                do {
                    if let newDiscountData = try? DiscountData(withDictionary: discount) {
                        if data.count < index + 1 {
                            data.append([newDiscountData])
                        } else {
                            data[index].append(newDiscountData)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - DiscountData
class DiscountData {
    
    let voucherCode: String
    let voucherDesc: String?
    let discountTitle: String?
    let discountDesc: String?
    let validTill: String?
    let isExpiringSoon: Bool?
    let discount: String?
    let seller: String?
    let shareData: String?
    let sellerType : SellerType
    
    enum keys : String {
        case voucherCode = "voucherCode"
        case voucherDesc = "voucherDesc"
        case discountTitle = "discountTitle"
        case discountDesc = "discountDesc"
        case validTill = "validTill"
        case isExpiringSoon = "isExpiringSoon"
        case discount = "discount"
        case seller = "seller"
        case shareData = "shareData"
    }
    
    init(withDictionary dict : [String : Any]) throws {
        if let code = dict[keys.voucherCode.rawValue] as? String {
            self.voucherCode = code
            self.voucherDesc = dict[keys.voucherDesc.rawValue] as? String
            self.discountTitle = dict[keys.discountTitle.rawValue] as? String
            self.discountDesc = dict[keys.discountDesc.rawValue] as? String
            self.validTill = dict[keys.validTill.rawValue] as? String
            self.isExpiringSoon = dict[keys.isExpiringSoon.rawValue] as? Bool
            self.discount = dict[keys.discount.rawValue] as? String
            self.seller = dict[keys.seller.rawValue] as? String
            self.shareData = dict[keys.shareData.rawValue] as? String
            self.sellerType = SellerType.sellerType(forSeller: seller?.lowercased() ?? "default")
        } else {
            throw DecodingError.runtimeError("Bad Discount Data")
        }
    }
    
    func getDiscount() -> String {
        return discount?.lowercased().replacingOccurrences(of: "off", with: "") ?? ""
    }
}

import UIKit

enum SellerType {
    case food, event, others
    
    static func sellerType(forSeller seller : String) -> SellerType {
        switch seller {
        case "swiggy", "zomato", "ubereats":
            return .food
        case "bookmyshow":
            return .event
        default:
            return .others
        }
    }
    
    func brandLogo(forSeller seller : String?) -> UIImage? {
        if self != .others {
            let directory = Bundle.main.bundlePath
            if let contentsArray = try? FileManager.default.contentsOfDirectory(atPath: directory) {
                let sellerName = seller?.lowercased() ?? "default"
                if contentsArray.contains(sellerName + ".png") {
                    let imageURL = URL(fileURLWithPath: directory).appendingPathComponent(sellerName + ".png")
                    let image = UIImage(contentsOfFile: imageURL.path)
                    return image
                }
            }
        }
        return UIImage.image(forText: seller ?? "default")
    }
    
    func brandBanner() -> UIImage {
        switch self {
        case .event:
            return #imageLiteral(resourceName: "Event_Banner")
        case .food:
            return #imageLiteral(resourceName: "food_banner")
        default:
            return #imageLiteral(resourceName: "other_banner")
        }
    }
    
}
