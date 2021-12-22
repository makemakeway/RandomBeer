//
//  MainView.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/22.
//

import UIKit

class MainView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        print(hitView)
        
        if (self == hitView) { return nil }
        
        return hitView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
