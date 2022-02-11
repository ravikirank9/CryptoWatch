//
//  CryptoAssetViewModel.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import Foundation

class CryptoAssetListViewModel {
    
    //MARK:- Variables
    
    private var cryptoWebService:CryptoWebServiceProtocol
    private var cryptoAssets: [CryptoAsset] = [] {
        didSet{
            dataFetched?()
        }
    }
    
    var dataFetched: (() -> Void)?
    var dataFetchFailed: ((_ message:String) -> Void)?
    var cryptoAssetCount:Int {
        return self.cryptoAssets.count
    }
    
    //MARK:- init method
    
    //requires CryptoWebService object as parameter
    init(apiService: CryptoWebServiceProtocol = CryptoWebService()) {
        cryptoWebService = apiService
    }
    
    //MARK:- Data 
    //fetches list of available crypto assets from web service
    func fetchCryptoAssetList(){
        
        cryptoWebService.getCryptoAssets { [unowned self] (success, assetList, error) in
            if success, error == nil {
                guard let fetchedAssets = assetList else {
                    handleDataFetchError("Something went wrong. Please try again.")
                    return
                }
                cryptoAssets = fetchedAssets
            } else {
                handleDataFetchError(error)
            }
        }
    }
    
    //returns CryptoCellUIModel object
    //requires index of the required object
    func cryptoAssetInfoForCellAt(row:Int) -> CryptoCellUIModel {
        let assetForRow = cryptoAssets[row]
        let rank = "# "+assetForRow.rank
        let priceText = "$ "+assetForRow.priceUsd.valueWithDecimalPalcesOf(3)
        let changeIn24Hrs = assetForRow.changePercent24Hr.valueWithDecimalPalcesOf(2)+"%"
        return CryptoCellUIModel(rank:rank, symbol: assetForRow.symbol, name: assetForRow.name, priceUsd:priceText, changePercent24Hr:changeIn24Hrs)
    }
    
    func getCryptoAssetIdAt(row:Int) -> String {
        let assetForRow = cryptoAssets[row]
        return assetForRow.id
    }
    
    //MARK:- Error Handling
    func handleDataFetchError(_ error:String?) {
        dataFetchFailed?(error ?? "Something went wrong. Please try again.")
    }
}
