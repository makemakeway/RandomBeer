//
//  BeerInfoTableViewCell.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/24.
//

import UIKit
import SnapKit

class BeerInfoTableViewCell: UITableViewCell {
    
    var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var pairingFoodLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    var foodTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pairing Food"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var tipsTitle: UILabel = {
        let label = UILabel()
        label.text = "Brewers Tips"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pairingFoodLabel.text = ""
    }
    
    func createView() {
        self.addSubview(containerView)
        containerView.addSubview(foodTitleLabel)
        containerView.addSubview(pairingFoodLabel)
        containerView.addSubview(tipsTitle)
        containerView.addSubview(tipsLabel)
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        foodTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        pairingFoodLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(foodTitleLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        tipsTitle.snp.makeConstraints { make in
            make.top.equalTo(pairingFoodLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.top.equalTo(tipsTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
