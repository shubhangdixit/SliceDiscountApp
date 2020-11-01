//
//  BusinessModel.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import Foundation

class BusinessModel : NSObject {
    var discountsData : DiscountsModel?
    static let shared = BusinessModel()
    
    func loadDiscountData(onSuccess success : @escaping (()->()), OnFailure failure : @escaping ((String?)->())) {
        DataManager.shared.fetchDisountsList {[weak self] data in
            self?.discountsData = data
            success()
        } andOnFailure: { errorMessage in
            failure(errorMessage)
        }
        
    }
}
