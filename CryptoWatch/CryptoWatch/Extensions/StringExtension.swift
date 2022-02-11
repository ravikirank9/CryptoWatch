//
//  StringExtension.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import Foundation

extension String {
    func valueWithDecimalPalcesOf(_ decimals:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = decimals
        return formatter.string(from: Double(self)! as NSNumber)!
    }
}
