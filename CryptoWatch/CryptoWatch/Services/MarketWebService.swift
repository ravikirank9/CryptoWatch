//
//  RatesWebService.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import UIKit

protocol MarketWebServiceProtocol {
    func getMarketsForCryptoWith(id:String, completion: @escaping (_ success: Bool, _ results: [Market]?, _ error: String?) -> ())
}

class MarketWebService: MarketWebServiceProtocol {
    
    func getMarketsForCryptoWith(id:String, completion: @escaping (Bool, [Market]?, String?) -> ()) {
        let reqUrl = CryptoAPI.getAssetList.rawValue+"/\(id)"+"/markets"
        HTTPRequestHelper().GET(url:reqUrl, params:["":""]) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Markets.self, from: data!)
                    completion(true, model.data, nil)
                } catch let error {
                    completion(false, nil, "Decoding to Markets model failed \(error.localizedDescription)")
                }
            } else {
                completion(false, nil, "Markets list GET Request failed")
            }
        }
    }
}
