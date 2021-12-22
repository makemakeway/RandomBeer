//
//  CustomTableView.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/22.
//

import UIKit

class CustomTableView: UITableView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        print(hitView)
//        if self == hitView {
//            return nil
//        }
        
        
        return hitView
    }
}
