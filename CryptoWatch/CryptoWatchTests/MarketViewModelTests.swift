//
//  MarketViewModelTest.swift
//  CryptoWatchTests
//
//  Created by Ravi Kiran on 11/02/22.
//

import XCTest
@testable import CryptoWatch

class MarketViewModelTests: XCTestCase {

    var viewModel : MarketViewModel!
    fileprivate var service : MockMarketoWebService!

    override func setUp() {
        super.setUp()
        service = MockMarketoWebService()
        viewModel = MarketViewModel(apiService: service)
    }
    
    func testDataFetch() {
        
        viewModel.fetchMarketsForCryptoWith("123")
        
        viewModel.dataFetched = {
            XCTAssert(true, "Data fetch test success")
        }
        
        viewModel.dataFetchFailed = { message in
            XCTAssert(false, "Data fetch test failed")
        }
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
}

fileprivate class MockMarketoWebService: MarketWebServiceProtocol {
    func getMarketsForCryptoWith(id: String, completion: @escaping (Bool, [Market]?, String?) -> ()) {
        let mockMarketsData = [Market(exchangeId: "Exc1", priceUsd:"12.34")]
        completion(true,mockMarketsData,nil)
    }
}
