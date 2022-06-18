//
//  ViewController.swift
//  CryptoObserver
//
//  Created by Dmitry Lapata on 18.06.22.
//

import UIKit

class ViewController: UIViewController {

    private let tabelView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        return tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

