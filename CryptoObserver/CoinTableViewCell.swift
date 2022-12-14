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
    let icon: URL?
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
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    //init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconView)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    //layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height/1.1
        iconView.frame = CGRect(x: 20,
                                y: (contentView.frame.size.height-size)/2,
                                width: size,
                                height: size)
        
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        symbolLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 20 + size,
                                 y: 0,
                                 width: contentView.frame.size.width/2,
                                 height: contentView.frame.size.height/2)
        
        symbolLabel.frame = CGRect(x: 20 + size,
                                   y: contentView.frame.size.height/2,
                                   width: contentView.frame.size.width/2,
                                   height: contentView.frame.size.height/2)
        
        symbolLabel.frame = CGRect(x: contentView.frame.size.width/2,
                                   y: 0,
                                   width: (contentView.frame.size.width/2)-20,
                                   height: contentView.frame.size.height)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil
    }
    
    //configure
    
    func configure(with viewModel: CoinTableViewCellViewModel){
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        symbolLabel.text = viewModel.symbol
        
        if let url = viewModel.icon {
            let task = URLSession.shared.dataTask(with: url)
            {[weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.iconView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
        
    }
}
