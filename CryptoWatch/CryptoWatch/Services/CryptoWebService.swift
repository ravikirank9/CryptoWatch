//
//  WebAPIService.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import Foundation

protocol CryptoWebServiceProtocol {
    func getCryptoAssets(completion: @escaping (_ success: Bool, _ results: [CryptoAsset]?, _ error: String?) -> ())
}

class CryptoWebService: CryptoWebServiceProtocol {
    func getCryptoAssets(completion: @escaping (Bool, [CryptoAsset]?, String?) -> ()) {
        HTTPRequestHelper().GET(url:CryptoAPI.getAssetList.rawValue, params: ["": ""]) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CryptoAssetList.self, from: data!)
                    completion(true, model.data, nil)
                } catch let error {
                    completion(false, nil, "Error: Trying to parse CryptoAsset to model \(error.localizedDescription)")
                }
            } else {
                completion(false, nil, "Error: CryptoAsset list GET Request failed")
            }
        }
    }
}
