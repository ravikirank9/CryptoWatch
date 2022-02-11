//
//  CryptoListViewController.swift
//  CryptoWatch
//
//  Created by Ravi Kiran on 11/02/22.
//

import UIKit

class CryptoListViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var cryptoListTableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    //MARK:- Properties
    lazy var viewModel: CryptoAssetListViewModel = {
        return CryptoAssetListViewModel()
    }()
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewUI()
        fetchData()
    }
    
    //MARK:- UI Methods
    func initViewUI(){
        loadingIndicatorView.startAnimating()
        cryptoListTableView.isHidden = true
        retryButton.isHidden = true
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
    func fetchData(){
        
        viewModel.fetchCryptoAssetList()
        
        viewModel.dataFetched = { [unowned self] in
            DispatchQueue.main.async {
                cryptoListTableView.isHidden = false
                cryptoListTableView.reloadData()
                loadingIndicatorView.stopAnimating()
            }
        }
        
        viewModel.dataFetchFailed = { [unowned self] message in
            DispatchQueue.main.async {
                retryButton.isHidden = false
                loadingIndicatorView.stopAnimating()
                showAlertWith(message: message)
            }
        }
    }
    
    //MARK:- Action Methods
    @IBAction func retryButtonClicked() {
        initViewUI()
        fetchData()
    }
}

//MARK:- TableView DataSource Methods

extension CryptoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cryptoAssetCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cryptoCell = tableView.dequeueReusableCell(withIdentifier: CryptoListTableViewCell.identifier, for: indexPath) as! CryptoListTableViewCell
        cryptoCell.cryptoAsset = viewModel.cryptoAssetInfoForCellAt(row: indexPath.row)
        return cryptoCell
    }
}

//MARK: - TableView Delegate Methods
extension CryptoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let marketVC = storyboard?.instantiateViewController(identifier:"MarketViewController") as? MarketViewController {
            marketVC.cryptoID = viewModel.getCryptoAssetIdAt(row: indexPath.row)
            navigationController?.show(marketVC, sender: nil)
        }
    }
}
