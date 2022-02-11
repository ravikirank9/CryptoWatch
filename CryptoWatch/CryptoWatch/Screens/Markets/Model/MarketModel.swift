//
//  RatesModel.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import Foundation

struct Markets:Codable {
    let data:[Market]
}

struct Market:Codable {
    let exchangeId:String
    let priceUsd:String
}
