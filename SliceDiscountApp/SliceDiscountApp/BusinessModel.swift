//
//  BusinessModel.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import Foundation

enum Status {
    case success
    case updating
    case error(String)
}

class BusinessManager : NSObject {
    @objc dynamic var discountsData : DiscountsModel?
    static let shared = BusinessManager()
    var dataStatus : Status = .updating
    
    func loadDiscountData(onSuccess success : @escaping (()->()), OnFailure failure : @escaping ((String?)->())) {
        dataStatus = .updating
        DataManager.shared.fetchDisountsList {[weak self] data in
            self?.discountsData = data
            self?.dataStatus = .success
            success()
        } andOnFailure: { errorMessage in
            self.dataStatus = .error(errorMessage ?? "")
            failure(errorMessage)
        }
    }
    
    func getNumberOfRors() -> Int {
        guard let discountsData = self.discountsData else {
            loadDiscountData {} OnFailure: {_ in
            }
            return 0
        }
        return discountsData.data.count
    }
    
    func getDiscountData(forRow row : Int) -> [DiscountData] {
        return discountsData?.data[row] ?? []
    }
}
