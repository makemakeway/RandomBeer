//
//  OverViewTableViewCell.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/21.
//

import UIKit
import SnapKit

class OverViewTableViewCell: UITableViewCell {

    var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true

        
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        return label
    }()
    
    var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "태그"
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        return label
    }()
    
    var pairingFoodLabel: UILabel = {
        let label = UILabel()
        label.text = "어울리는 음식"
        return label
    }()
    
    var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "꿀팁"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("----------awakeFromNib----------")
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUI() {
        print("OverView UI 설정")
        self.contentView.addSubview(containerView)
        
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.7
        
        containerView.backgroundColor = .darkGray
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        let vstack = UIStackView()
        vstack.alignment = .center
        vstack.axis = .vertical
        vstack.spacing = 20
        vstack.distribution = .fill
        vstack.backgroundColor = .systemTeal
        
        containerView.addSubview(vstack)
        
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let padding = UIView()
        padding.snp.makeConstraints { make in
            make.height.equalTo(0)
        }
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.required, for: .vertical)
        
        vstack.addArrangedSubview(padding)
        vstack.addArrangedSubview(nameLabel)
        vstack.addArrangedSubview(descriptionLabel)
        vstack.addArrangedSubview(tagLabel)
        vstack.addArrangedSubview(spacer)
    }
}
