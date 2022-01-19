import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812 - 0.0
fileprivate let widthRatio = userWidth / 375 - 0.0
fileprivate let cellHeight = 68 * heightRatio

class FriendsListVC: UIViewController {
    
    // MARK: - properties
    
    static let identifier: String = "FriendsListVC"
    
    private let topView: UIView = UIView().then {
        $0.backgroundColor = UIColor.clear
    }
    
    private let navigationTitleLabel: UILabel = UILabel().then {
        $0.text = "친구"
        $0.textColor = UIColor.grey06
        $0.font = UIFont.hanSansMediumFont(ofSize: 18)
    }
    
    private let backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_back"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
    }
    
    private let addFriendsButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_add-friends"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpAddFriendsButton(_:)), for: .touchUpInside)
    }
    
    private let searchBar: SMSearchBar = SMSearchBar().then {
        $0.placeholder = "친구 검색"
    }
    
    private let separator: UIView = UIView().then {
        $0.backgroundColor = UIColor.clear
    }
    
    private let tableView: UITableView = UITableView().then {
        $0.register(FriendsListTVC.self, forCellReuseIdentifier: FriendsListTVC.identifier)
    }
    
    private lazy var emptyImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "img_illust_9")
    }
    
    private lazy var emptyMessageLabel1: UILabel = UILabel().then {
        $0.font = UIFont.hanSansRegularFont(ofSize: 16)
        $0.textColor = UIColor.grey05
        $0.text = "등록된 친구가 없어요!"
    }
    
    private lazy var emptyMessageLabel2: UILabel = UILabel().then {
        $0.font = UIFont.hanSansRegularFont(ofSize: 16)
        $0.textColor = UIColor.grey05
        $0.text = "친구를 추가해 주세요"
    }
    
    var friendsNameData: [String] = []
    var filteredNameData: [String] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
    }
    
    private func setLayouts() {
        view.dismissKeyboardWhenTappedAround()
        view.addSubviews([topView, searchBar, separator,tableView])
        topView.addSubviews([navigationTitleLabel, backButton, addFriendsButton])
        
        topView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(102 * heightRatio)
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(48 * heightRatio)
            $0.leading.equalTo(2 * widthRatio)
            $0.bottom.equalTo(5 * heightRatio)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-11 * heightRatio)
            $0.leading.equalTo(backButton.snp.trailing).offset(120 * widthRatio)
        }
        
        addFriendsButton.snp.makeConstraints {
            $0.width.height.equalTo(48 * heightRatio)
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.trailing.equalToSuperview().offset(-11 * widthRatio)
        }
        
        searchBar.delegate = self
        searchBar.snp.makeConstraints {
            $0.width.equalTo(335 * widthRatio)
            $0.height.equalTo(50 * heightRatio)
            $0.top.equalTo(topView.snp.bottom).offset(14 * heightRatio)
            $0.centerX.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom).offset(14 * heightRatio)
            $0.height.equalTo(1)
        }
        
        // 데이터유무에 따라 분기 처리 필요
        if friendsNameData.isEmpty {
            setLayoutsIfEmptyTable()
        } else {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20 * widthRatio)
                $0.trailing.equalToSuperview().offset(-11 * widthRatio)
                $0.bottom.equalToSuperview()
                $0.top.equalTo(separator.snp.bottom)
            }
        }
    }
    
    private func setLayoutsIfEmptyTable() {
        view.addSubviews([emptyImage, emptyMessageLabel1, emptyMessageLabel2])
        emptyImage.snp.makeConstraints {
            $0.width.height.equalTo(164 * heightRatio)
            $0.top.equalTo(searchBar.snp.bottom).offset(135 * heightRatio)
            $0.centerX.equalToSuperview()
        }
        
        emptyMessageLabel1.snp.makeConstraints {
            $0.top.equalTo(emptyImage.snp.bottom).offset(17 * heightRatio)
            $0.centerX.equalToSuperview()
        }
        
        emptyMessageLabel2.snp.makeConstraints {
            $0.top.equalTo(emptyMessageLabel1.snp.bottom).offset(4 * heightRatio)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - objc func
    
    @objc private func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func touchUpAddFriendsButton(_ sender: UIButton) {
        
    }
    
    // MARK: - tableview Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.contentOffset.y.isZero {
            separator.backgroundColor = UIColor.grey02
        } else {
            separator.backgroundColor = UIColor.clear
        }
    }
}

// MARK: - Extensions

extension FriendsListVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = UIColor.pink01.cgColor
        searchBar.layer.borderWidth = 1
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = nil
        searchBar.layer.borderWidth = 0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredNameData = friendsNameData.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        } else {
            filteredNameData.removeAll()
        }
        tableView.reloadData() // 일단은 음절단위로 갑시다!
    }
}

extension FriendsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredNameData.isEmpty {
            return friendsNameData.count
        } else {
            return filteredNameData.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListTVC.identifier, for: indexPath) as? FriendsListTVC else { return UITableViewCell() }
        if filteredNameData.isEmpty {
            cell.nameLabel.text = friendsNameData[indexPath.row]
        } else {
            cell.nameLabel.text = filteredNameData[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
