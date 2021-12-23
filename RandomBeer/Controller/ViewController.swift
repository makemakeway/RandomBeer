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
    
    var model = [BeerModel]()
    
    var spread = false
    
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
        header.isUserInteractionEnabled = false
        return header
    }()
    
    var footerBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .magenta
        return toolbar
    }()
    
    //MARK: Method
    
    @objc func refreshBeer(_ sender: UIBarButtonItem) {
        fetchRandomBeer()
    }
    
    @objc func shareButtonClicked(_ sender: UIBarButtonItem) {
        print("share")
    }
    
    func tableViewConfig() {
        print(#function)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = headerView
        tableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
        tableView.register(BeerInfoTableViewCell.self, forCellReuseIdentifier: BeerInfoTableViewCell.reuseIdentifier)
    }
    
    func toolBarConfig() {
        let fixed = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixed.width = 20
//        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath"), style: .plain, target: self, action: #selector(refreshBeer(_:)))
        
        let button = UIButton()
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemTeal.cgColor
        button.tintColor = .systemTeal
        button.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        button.addTarget(self, action: #selector(refreshBeer(_:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        
        let buttonForShare = UIButton()
        buttonForShare.layer.borderWidth = 5
        buttonForShare.layer.cornerRadius = 10
        buttonForShare.layer.borderColor = UIColor.systemTeal.cgColor
        buttonForShare.tintColor = .white
        buttonForShare.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        buttonForShare.addTarget(self, action: #selector(shareButtonClicked(_:)), for: .touchUpInside)
        buttonForShare.setTitle("Share", for: .normal)
        
        
        let refreshButton = UIBarButtonItem(customView: button)
        
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 10
        let shareButton = UIBarButtonItem(customView: buttonForShare)
        
        footerBar.setItems([fixed, refreshButton, space, shareButton], animated: false)
    }
    
    func fetchRandomBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        LoadingIndicator.shared.showIndicator()
        AF.request(url).responseDecodable(of: [BeerModel].self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                self.model = value
                if let url = self.model.first?.imageUrl {
                    AF.request(url).responseData { data in
                        
                        guard let data = data.value else {
                            return
                        }
                        LoadingIndicator.shared.hideIndicator()
                        self.headerView.imageView.image = UIImage(data: data)
                        self.tableView.reloadData()
                    }
                } else {
                    LoadingIndicator.shared.hideIndicator()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        toolBarConfig()
        tableViewConfig()
        fetchRandomBeer()
        
        view.addSubview(footerBar)
        footerBar.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = model.first else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as? OverViewTableViewCell else {
                print("변환 실패 ㅠㅠ")
                return UITableViewCell()
            }
            
            cell.nameLabel.text = data.name
            cell.tagLabel.text = data.tag
            cell.descriptionLabel.text = data.description
            
            if spread {
                cell.descriptionLabel.numberOfLines = 0
            } else {
                cell.descriptionLabel.numberOfLines = 3
            }
            
            
            cell.layer.zPosition = 100
            tableView.bringSubviewToFront(cell)
            tableView.layer.masksToBounds = true
            
            cell.delegate = self
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerInfoTableViewCell.reuseIdentifier, for: indexPath) as? BeerInfoTableViewCell else {
                return UITableViewCell()
            }
            data.pairingFood.forEach({
                cell.pairingFoodLabel.text! += $0 + "\n"
            })
            cell.tipsLabel.text = data.tips
            cell.tipsLabel.numberOfLines = 0
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1:
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
        spread.toggle()
        tableView.reloadData()
    }
}
