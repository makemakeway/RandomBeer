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
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "태그"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    var delegate: Foldable?
    
    @objc func moreButtonClicked(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.spreadOrFold()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        moreButton.addTarget(self, action: #selector(moreButtonClicked(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        let vstack = UIStackView()
        vstack.alignment = .fill
        vstack.axis = .vertical
        vstack.spacing = 20
        vstack.distribution = .fill
        
        containerView.addSubview(vstack)
        containerView.backgroundColor = .white
        
        vstack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        moreButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        vstack.addArrangedSubview(UIView())
        vstack.addArrangedSubview(nameLabel)
        vstack.addArrangedSubview(tagLabel)
        vstack.addArrangedSubview(descriptionLabel)
        vstack.addArrangedSubview(spacer)
        vstack.addArrangedSubview(moreButton)
        vstack.addArrangedSubview(UIView())
        
        
        
    }
}
