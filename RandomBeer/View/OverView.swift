//
//  OverView.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/21.
//

import UIKit
import SnapKit

class OverView: UIView {
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var tagLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var pairingFoodLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var tipsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func createView() {
        self.addSubview(containerView)
        
//        containerView.addSubview(nameLabel)
//        containerView.addSubview(tagLabel)
//        containerView.addSubview(descriptionLabel)
//        containerView.addSubview(pairingFoodLabel)
//        containerView.addSubview(tipsLabel)
        
        containerView.backgroundColor = .magenta
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
