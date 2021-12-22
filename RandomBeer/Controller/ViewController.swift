//
//  ViewController.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/20.
//

import UIKit
import SnapKit
import Alamofire

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
    
    lazy var tableView: CustomTableView = {
        let tableView = CustomTableView()
        return tableView
    }()
    
    var headerView: HeaderView = {
        let header = HeaderView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: UIScreen.main.bounds.width))
        header.imageView.image = UIImage(named: "IMG")
        header.isUserInteractionEnabled = false
        return header
    }()
    
    //MARK: Method
    
    func tableViewConfig() {
        print(#function)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = headerView
        tableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
    }
    
    func fetchRandomBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
//        AF.request("https://api.punkapi.com/v2/beers/random").responseDecodable { response in
//            switch response.result {
//            case .success(let data):
//                guard let data = data else { return }
//                let decoder = JSONDecoder()
//                let value = try? decoder.decode(BeerModel.self, from: data)
//                print(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        AF.request(url).responseDecodable(of: BeerModel.self) { response in
            print(response.value)
        }
    }
    
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        tableViewConfig()
        tableView.backgroundColor = .green
        fetchRandomBeer()
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
            tableView.bringSubviewToFront(cell)
            
            tableView.layer.masksToBounds = true
            
//            self.tableView.bringSubviewToFront(cell.contentView.superview!)
//            self.tableView.tableHeaderView!.isUserInteractionEnabled = false
//            print(cell.superview)
//            print(tableView.tableHeaderView?.superview)
//            print(cell.contentView.superview?.superview)
//            superView.bringSubviewToFront(cell)
            self.tableView.sendSubviewToBack(headerView)
//            self.tableView.bringSubviewToFront(headerView)
//            self.tableView.insertSubview(headerView, belowSubview: cell)
            
            
            
            cell.delegate = self
            
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
