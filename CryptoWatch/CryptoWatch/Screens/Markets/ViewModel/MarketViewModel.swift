//
//  MarketViewModel.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import Foundation

class MarketViewModel {
    //MARK:- Variables
    
    private var marketWebService:MarketWebServiceProtocol
    private var markets: [Market] = [] {
        didSet{
            dataFetched?()
        }
    }
    
    var dataFetched: (() -> Void)?
    var dataFetchFailed: ((_ message:String) -> Void)?
    var ratesCount:Int {
        return self.markets.count
    }
    
    //MARK:- init method
    //requires CryptoWebService object as parameter
    init(apiService: MarketWebServiceProtocol = MarketWebService()) {
        marketWebService = apiService
    }
    
    //MARK:- Data Fetching
    //fetches list of available crypto assets from web service
    func fetchMarketsForCryptoWith(_ cryptoId:String){
        
        marketWebService.getMarketsForCryptoWith(id: cryptoId) { [unowned self] (success, marketList, error) in
            if success, error == nil {
                guard let fetchedMarkets = marketList else {
                    handleDataFetchError("Unable to get Market list")
                    return
                }
                markets = fetchedMarkets.sorted(by: { (market1, market2) -> Bool in
                    return market1.exchangeId.compare(market2.exchangeId) == .orderedAscending
                })
            } else {
                handleDataFetchError(error)
            }
        }
    }
    
    //returns MarketCellUIModel object
    //requires index of the required object
    func marketInfoForCellAt(row:Int) -> MarketCellUIModel {
        let marketForRow = markets[row]
        let priceText = "$ "+marketForRow.priceUsd.valueWithDecimalPalcesOf(3)
        return MarketCellUIModel(marketName: marketForRow.exchangeId.capitalized, marketPrice: priceText)
    }
    
    //MARK:- Error Handling
    func handleDataFetchError(_ error:String?) {
        dataFetchFailed?(error ?? "Something went wrong. Please try again.")
    }
}
