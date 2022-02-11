//
//  CryptoAsset.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import Foundation

struct CryptoAssetList:Codable {
    let data:[CryptoAsset]
}

struct CryptoAsset: Codable {
    let id:String
    let rank:String
    let symbol:String
    let name:String
    let priceUsd:String
    let changePercent24Hr:String
}
