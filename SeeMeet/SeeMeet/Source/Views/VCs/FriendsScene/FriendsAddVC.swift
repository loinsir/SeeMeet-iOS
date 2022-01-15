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

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
    }
    
    private func setLayouts() {
        view.dismissKeyboardWhenTappedAround()
        view.addSubviews([topView, searchBar, tableView])
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
        
    }
    
    // MARK: - objc
    
    @objc private func touchUpCloseButton(_ sender: UIButton) {
        
    }

}

// MARK: - Extensions

extension FriendsAddVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = UIColor.pink01.cgColor
        searchBar.layer.borderWidth = 1
        print("HIHI")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = nil
        searchBar.layer.borderWidth = 0
    }
}

extension FriendsAddVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FriendsAddTVC = tableView.dequeueReusableCell(withIdentifier: FriendsAddTVC.identifier) as? FriendsAddTVC else { return UITableViewCell() }
        
        return cell
    }
}

extension FriendsAddVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
