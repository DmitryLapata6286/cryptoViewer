//
//  ViewController.swift
//  CryptoObserver
//
//  Created by Dmitry Lapata on 18.06.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CoinTableViewCell.self,
                           forCellReuseIdentifier: CoinTableViewCell.identifier)
        return tableView
    }()
    
    private var viewModels = [CoinTableViewCellViewModel]()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.formatterBehavior = .default
        
        return formatter
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cryptocoins Viewer"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        APICaller.shared.getCoinsData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({
                    
                    let price = $0.priceUsd ?? 0
                    
                    return CoinTableViewCellViewModel(
                        name: $0.name ?? "N/A",
                        symbol: $0.assetID ?? "",
                        price: ViewController.numberFormatter.string(from: NSNumber(value: price)) ?? "N/A")
                    
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier,
                                                 for: indexPath
        ) as? CoinTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

