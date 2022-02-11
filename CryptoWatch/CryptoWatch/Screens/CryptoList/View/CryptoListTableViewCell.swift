//
//  CryptoListTableViewCell.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import UIKit

class CryptoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var changePercentageLabel: UILabel!
    
    //Table cell identifier
    class var identifier: String { return String(describing: self) }
    
    var cryptoAsset:CryptoCellUIModel?{
        didSet{
            rankLabel.text = cryptoAsset?.rank
            symbolLabel.text = cryptoAsset?.symbol
            coinNameLabel.text = cryptoAsset?.name
            coinPriceLabel.text = cryptoAsset?.priceUsd
            changePercentageLabel.text = cryptoAsset?.changePercent24Hr
            changePercentageLabel.textColor = cryptoAsset?.changePercent24Hr.starts(with: "-") ?? false ? UIColor.systemRed : UIColor.systemGreen
        }
    }
    
    //Clearing cell labels for reusing
    override func prepareForReuse() {
        super.prepareForReuse()
        rankLabel.text = nil
        symbolLabel.text = nil
        coinNameLabel.text = nil
        coinPriceLabel.text = nil
        changePercentageLabel.text = nil
    }
}
