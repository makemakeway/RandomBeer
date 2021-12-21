//
//  ViewController.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    
    //MARK: Properties
    
    let model = [
        "Hongkong",
        "Seoul",
        "NewYork",
        "Tokyo",
        "Busan",
        "Suwon",
        "Guro",
        "Inchon",
        "Daegu",
        "Gwangju",
        "Mockpo",
        "Daejeon",
        "GwangMyeong"
    ]
    
    
    //MARK: UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    
    //MARK: Method
    
    func tableViewConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let header = HeaderView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: view.frame.size.width))
        header.imageView.image = UIImage(named: "IMG")
        tableView.tableHeaderView = header
        tableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
    }
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
        tableViewConfig()
        tableView.backgroundColor = .green

    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as? OverViewTableViewCell else {
                print("변환 실패 ㅠㅠ")
                return UITableViewCell()
            }
            print("변환성공")
            cell.nameLabel.text = "제목입니다."
            cell.tagLabel.text = "종류입니다."
            cell.descriptionLabel.text = "설명입니다."
            cell.layer.zPosition = 100
            cell.delegate = self
            tableView.layer.zPosition = 0
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        default:
            return 50
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? HeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension ViewController: Foldable {
    func spreadOrFold() {
        print("fold")
    }
}
