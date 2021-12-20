//
//  HeaderView.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/20.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    let containerView = UIView()
    let image = UIImageView(image: UIImage(systemName: "star"))
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let styleLabel = UILabel()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    
    private var imageViewBottom: Constraint!
    private var imageViewHeight: Constraint!
    private var containerViewHeight: Constraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UIConfigration()
        self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    func UIConfigration() {
        addSubview(containerView)
        containerView.addSubview(image)
        image.contentMode = .scaleAspectFill
        
        self.snp.makeConstraints { make in
            make.width.equalTo(containerView.snp.width)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.equalTo(containerView.snp.height)
        }
        
        containerView.snp.makeConstraints { make in
            containerViewHeight = make.height.equalToSuperview().constraint
//            containerViewHeight.isActive = true
        }
        
        
        image.snp.makeConstraints { make in
            
            imageViewBottom = make.bottom.equalToSuperview().constraint
//            imageViewBottom.isActive = true
            
            imageViewHeight = make.height.equalToSuperview().constraint
//            imageViewHeight.isActive = true
        }
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        containerViewHeight.off = scrollView.contentInset.top
//        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
//        containerView.clipsToBounds = offsetY <= 0
//        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
//        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
