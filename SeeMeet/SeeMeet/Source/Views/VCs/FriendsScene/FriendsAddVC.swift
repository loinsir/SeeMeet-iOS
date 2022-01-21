import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let userIndicatorHeight = CGFloat(UIScreen.getIndecatorHeight())
fileprivate let heightRatio = userHeight / 812 - 0.0
fileprivate let widthRatio = userWidth / 375 - 0.0
fileprivate let cellHeight = 53 * heightRatio

class FriendsAddVC: UIViewController {
    
    // MARK: - properties
    static let identifier: String = "FriendsAddVC"
    
    var resultCompletion: (() -> ())?
    
    private let topView: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey06
    }
    
    private let navigationTitleLabel: UILabel = UILabel().then {
        $0.text = "친구 추가"
        $0.font = UIFont.hanSansMediumFont(ofSize: 18)
        $0.textColor = UIColor.white
    }
    
    private let closeButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_close_white"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpCloseButton(_:)), for: .touchUpInside)
    }
    
    private let searchBar: SMSearchBar = SMSearchBar().then {
        $0.placeholder = "친구 아이디"
    }
    
    private lazy var tableView: UITableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(FriendsAddTVC.self, forCellReuseIdentifier: FriendsAddTVC.identifier)
    }
    
    private let undefinedLabel: UILabel = UILabel().then {
        $0.text = "검색 결과가 없습니다."
        $0.font = UIFont.hanSansRegularFont(ofSize: 16)
        $0.textColor = UIColor.grey03
        $0.isHidden = true
    }
    
    private var searchResults: FriendData? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
    }
    
    private func setLayouts() {
        view.dismissKeyboardWhenTappedAround()
        view.addSubviews([topView, searchBar, tableView, undefinedLabel])
        topView.addSubviews([navigationTitleLabel, closeButton])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            if UIScreen.hasNotch {
                $0.height.equalTo(102 * heightRatio)
            } else {
                $0.height.equalTo((58 + userIndicatorHeight) * heightRatio)
            }
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15 * heightRatio)
            $0.leading.equalToSuperview().offset(152 * widthRatio)
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(48 * heightRatio)
            $0.trailing.equalToSuperview().offset(-5 * widthRatio)
            $0.bottom.equalToSuperview().offset(-4 * heightRatio)
        }
        
        searchBar.delegate = self
        searchBar.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(14 * heightRatio)
            $0.leading.equalToSuperview().offset(20 * widthRatio)
            $0.trailing.equalToSuperview().offset(-20 * widthRatio)
            $0.height.equalTo(50 * heightRatio)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints {
            $0.leading.equalTo(20 * widthRatio)
            $0.trailing.equalTo(-14 * widthRatio)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom).offset(30 * heightRatio)
        }
        
        undefinedLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(47 * heightRatio)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    private func requestFriendsSearchResults(email: String) {
        FriendsSearchService.shared.searchFriends(email: email) { responseData in
            switch responseData {
            case .success(let response):
                guard let response = response as? FriendsSearchResponseModel else { return }
                self.searchResults = response.data
                self.undefinedLabel.isHidden = true
                self.tableView.isHidden = false
                
            case .requestErr(let response):
                self.undefinedLabel.isHidden = false
                self.tableView.isHidden = true
            case .pathErr:
//                self.view.makeToastAnimation(message: "존재하지 않는 회원입니다.")
                print("Path Error")
                self.undefinedLabel.isHidden = false
                self.tableView.isHidden = true
            case .serverErr:
                self.undefinedLabel.isHidden = false
                self.tableView.isHidden = true
                print("Server Error")
            case .networkFail:
                self.undefinedLabel.isHidden = false
                self.tableView.isHidden = true
                print("Network Fail")
            }
        }
    }
    
    // MARK: - objc
    
    @objc private func touchUpCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: resultCompletion)
    }

}

// MARK: - Extensions

extension FriendsAddVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = UIColor.pink01.cgColor
        searchBar.layer.borderWidth = 1
        undefinedLabel.isHidden = true
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = nil
        searchBar.layer.borderWidth = 0
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // 키보드 완료
        searchBar.endEditing(true)
        guard let searchEmail = searchBar.text else { return }
        requestFriendsSearchResults(email: searchEmail)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            tableView.isHidden = true
        }
    }
}

extension FriendsAddVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FriendsAddTVC = tableView.dequeueReusableCell(withIdentifier: FriendsAddTVC.identifier) as? FriendsAddTVC else { return UITableViewCell() }
        cell.nameLabel.text = searchResults?.username
        cell.emailLabel.text = searchResults?.email
        cell.delegate = self
        return cell
    }
}

extension FriendsAddVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension FriendsAddVC: FriendsAddTVCDelegate {
    func friendsAddTVC(cell: FriendsAddTVC, resultMessage: String) {
        view.makeToastAnimation(message: resultMessage)
    }
}
