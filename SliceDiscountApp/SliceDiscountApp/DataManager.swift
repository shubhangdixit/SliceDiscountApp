//
//  DataManager.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import Foundation

class DataManager : NSObject {
    
    static let shared = DataManager()
    
    func fetchDisountsList(onSuccess success : @escaping ((DiscountsModel?)->()), andOnFailure failure :  @escaping ((String?)->()) ) {
        
        if let filepath = Bundle.main.path(forResource: offlineDiscountListFile, ofType: "") {
            let urlVal = URL(fileURLWithPath: filepath)
            do {
                let data = try? Data(contentsOf: urlVal)
                let jsonInfo = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                if let info = jsonInfo as? [String:Any] {
                    let data = try? DiscountsModel.init(withDictionary: info)
                    success(data)
                }
            } catch DecodingError.runtimeError(let errorMessage) {                failure(errorMessage)
            } catch {
                failure("error in parsing")
            }
        }
    }
    
}
