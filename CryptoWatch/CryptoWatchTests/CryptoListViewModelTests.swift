//
//  CryptoListViewModelTests.swift
//  CryptoWatchTests
//
//  Created by Ravi Kiran on 11/02/22.
//

import XCTest
@testable import CryptoWatch

class CryptoListViewModelTests: XCTestCase {
    
    var viewModel : CryptoAssetListViewModel!
    fileprivate var service : MockCryptoWebService!

    override func setUp() {
        super.setUp()
        service = MockCryptoWebService()
        viewModel = CryptoAssetListViewModel(apiService: service)
    }
    
    func testDataFetch() {
        
        viewModel.fetchCryptoAssetList()
        
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

fileprivate class MockCryptoWebService: CryptoWebServiceProtocol {
    func getCryptoAssets(completion: @escaping (Bool, [CryptoAsset]?, String?) -> ()) {
        let mockData = [CryptoAsset(id:"ID1", rank:"1", symbol:"BTC", name:"Bitcoin", priceUsd:"12.34", changePercent24Hr:"0.12")]
        completion(true,mockData,nil)
    }
}
