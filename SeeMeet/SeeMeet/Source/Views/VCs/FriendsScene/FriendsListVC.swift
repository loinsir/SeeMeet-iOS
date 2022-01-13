import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812 - 0.0
fileprivate let widthRatio = userWidth / 375 - 0.0

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
    
    private let resultTableView: UITableView = UITableView().then {
        $0.register(FriendsListTVC.self, forCellReuseIdentifier: FriendsListTVC.identifier)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
    }
    
    private func setLayouts() {
        view.dismissKeyboardWhenTappedAround()
        view.addSubviews([topView, searchBar, resultTableView])
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
        
        
    }
    
    // MARK: - objc func
    
    @objc private func touchUpBackButton(_ sender: UIButton) {
        
    }
    
    @objc private func touchUpAddFriendsButton(_ sender: UIButton) {
        
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
}

extension FriendsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListTVC.identifier, for: indexPath) as? FriendsListTVC else { return UITableViewCell() }
        
        return cell
    }
    

}

extension FriendsListVC: UITableViewDelegate {
    
}
