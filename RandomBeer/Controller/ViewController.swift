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
    
    var beerInfo: BeerModel?
    
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
    
    var footerView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    
    //MARK: Method
    
    @objc func refreshBeer(_ sender: UIBarButtonItem) {
        fetchRandomBeer()
    }
    
    @objc func shareButtonClicked(_ sender: UIBarButtonItem) {
        print("share")
        createJson()
        var urlPaths = [URL]()
        if let path = documentDirectoryPath() {
            let json = (path as NSString).appendingPathComponent("beerInfo.json")
            if FileManager.default.fileExists(atPath: json) {
                urlPaths.append(URL(string: json)!)
            } else {
                print("저장할 데이터가 없습니다")
            }
        }
        presentActivityViewController()
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("beerInfo.json")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion:  nil)
    }
    
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directory = path.first {
            return directory
        } else {
            return nil
        }
    }
    
    func createJson() {
        guard let beerInfo = beerInfo else {
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let json = try encoder.encode(beerInfo)
            guard let jsonString = String(data: json, encoding: .utf8) else { return }
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                      in: .userDomainMask).first else { return }
            let jsonFilePath = documentDirectory.appendingPathComponent("beerInfo.json")
            
            try jsonString.write(to: jsonFilePath, atomically: true, encoding: .utf8)
            
        } catch {
            print("ERROR")
        }
        
    }
    
    func tableViewConfig() {
        print(#function)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = headerView
        tableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
        tableView.register(BeerInfoTableViewCell.self, forCellReuseIdentifier: BeerInfoTableViewCell.reuseIdentifier)
    }
    
    func footerViewConfig() {
        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }

        let refreshButton = UIButton()
        refreshButton.layer.borderWidth = 2
        refreshButton.layer.cornerRadius = 5
        refreshButton.layer.borderColor = UIColor.systemTeal.cgColor
        refreshButton.tintColor = .systemTeal
        refreshButton.addTarget(self, action: #selector(refreshBeer(_:)), for: .touchUpInside)
        refreshButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        refreshButton.setContentHuggingPriority(.required, for: .horizontal)
        
        let leadingPadding = UIView()
        
        leadingPadding.snp.makeConstraints { make in
            make.width.equalTo(0)
        }
        
        let shareButton = UIButton()
        shareButton.layer.borderWidth = 2
        shareButton.layer.cornerRadius = 5
        shareButton.layer.borderColor = UIColor.systemTeal.cgColor
        shareButton.tintColor = .systemTeal
        shareButton.addTarget(self, action: #selector(shareButtonClicked(_:)), for: .touchUpInside)
        shareButton.setTitle("Share Beer", for: .normal)
        shareButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        shareButton.backgroundColor = .systemTeal
        
        let trailingPadding = UIView()
        
        trailingPadding.snp.makeConstraints { make in
            make.width.equalTo(0)
        }
        
        footerView.addArrangedSubview(leadingPadding)
        footerView.addArrangedSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        footerView.addArrangedSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        footerView.addArrangedSubview(trailingPadding)
    }
    
    func fetchRandomBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        LoadingIndicator.shared.showIndicator()
        AF.request(url).responseDecodable(of: [BeerModel].self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                self.model = value
                self.beerInfo = value.first!
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
        view.backgroundColor = .systemBackground
        tableViewConfig()
        footerViewConfig()
        fetchRandomBeer()
        
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
            cell.pairingFoodLabel.numberOfLines = 0
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
        
        return UITableView.automaticDimension
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
