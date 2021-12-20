//
//  OverViewTableViewCell.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/21.
//

import UIKit
import 

class OverViewTableViewCell: UITableViewCell {

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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUI() {
        self.contentView.addSubview(containerView)
        
    }
}
