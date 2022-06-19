//
//  CoinTableViewCell.swift
//  CryptoObserver
//
//  Created by Dmitry Lapata on 18.06.22.
//

import UIKit

struct CoinTableViewCellViewModel {
    let name: String
    let symbol: String
    let price: String
}

class CoinTableViewCell: UITableViewCell {

    // MARK: - Variables
    static let identifier = "CoinTableViewCell"
    
    //subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    
    //init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    //layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        symbolLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 15, y: 0,
                                 width: contentView.frame.size.width/2,
                                 height: contentView.frame.size.height/2)
        
        symbolLabel.frame = CGRect(x: 15,
                                   y: contentView.frame.size.height/2,
                                   width: contentView.frame.size.width/2,
                                   height: contentView.frame.size.height/2)
        
        symbolLabel.frame = CGRect(x: contentView.frame.size.width/2,
                                   y: 0,
                                   width: (contentView.frame.size.width/2)-15,
                                   height: contentView.frame.size.height)

    }
    
    //configure
    
    func configure(with viewModel: CoinTableViewCellViewModel){
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        symbolLabel.text = viewModel.symbol
        
    }
}
