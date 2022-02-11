//
//  RatesTableViewCell.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import UIKit

class MarketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var marketPrice: UILabel!
    
    //Table cell identifier
    class var identifier: String { return String(describing: self) }
    
    var market:MarketCellUIModel? {
        didSet{
            marketName.text = market?.marketName
            marketPrice.text = market?.marketPrice
        }
    }
    
    //Clearing cell labels for reusing
    override func prepareForReuse() {
        super.prepareForReuse()
        marketName.text = nil
        marketPrice.text = nil
    }
}
