//
//  MarketViewController.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import UIKit

class MarketViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var marketsTableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    //MARK:- Properties
    var cryptoID:String!
    lazy var viewModel: MarketViewModel = {
        return MarketViewModel()
    }()
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewUI()
        initViewModel()
    }
    
    //MARK:- UI Methods
    func initViewUI(){
        loadingIndicatorView.startAnimating()
        marketsTableView.isHidden = true
    }
    
    func showAlertWith(message:String) {
        let alertVC = UIAlertController(title:nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title:"OK", style:.cancel, handler: { (cancel) in
        }))
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK:- ViewModel interactions
    
    //Asking view model to fetch data from network
    //Implementing dataFetched closure to listen when data came
    //Implementing showAlert closure to show network related error alerts
    func initViewModel(){
        
        viewModel.fetchMarketsForCryptoWith(cryptoID)
        
        viewModel.dataFetched = { [unowned self] in
            DispatchQueue.main.async {
                marketsTableView.isHidden = false
                marketsTableView.reloadData()
                loadingIndicatorView.stopAnimating()
            }
        }
        
        viewModel.dataFetchFailed = { [unowned self] message in
            DispatchQueue.main.async {
                loadingIndicatorView.stopAnimating()
                showAlertWith(message: message)
            }
        }
    }
}

//MARK:- TableView DataSource Methods

extension MarketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.ratesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marketCell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        marketCell.market = viewModel.marketInfoForCellAt(row: indexPath.row)
        return marketCell
    }
}

