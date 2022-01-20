import UIKit
import SwiftUI

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812
fileprivate let widthRatio = userWidth / 375

protocol FriendsAddTVCDelegate {
    func friendsAddTVC(cell: FriendsAddTVC, resultMessage: String)
}

class FriendsAddTVC: UITableViewCell {
    
    // MARK: - properties
    
    static let identifier: String = "FriendsAddTVC"
    
    var delegate: FriendsAddTVCDelegate?
    
    let profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "img_illust_2")
    }
    
    let nameLabel: UILabel = UILabel().then {
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.black
    }
    
    let emailLabel: UILabel = UILabel().then {
        $0.font = UIFont.hanSansMediumFont(ofSize: 13)
        $0.textColor = UIColor.grey04
    }
    
    private let addButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_add-friends_circle"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpAddButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setLayouts()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayouts()
    }
    
    private func setLayouts() {
        selectionStyle = .none
        
        addSubviews([profileImage, nameLabel, emailLabel])
        contentView.addSubview(addButton)
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(42 * heightRatio)
            $0.top.equalToSuperview().offset(5 * heightRatio)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(24 * widthRatio)
            $0.top.equalToSuperview().offset(6 * heightRatio)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(3 * heightRatio)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(48 * widthRatio)
            $0.top.equalToSuperview().offset(2 * heightRatio)
        }
    }
    
    // MARK: - objc
    
    @objc private func touchUpAddButton(_ sender: UIButton) {
        requestAddFriend()
    }
    
    private func requestAddFriend() {
        guard let email = emailLabel.text else { return }
        FriendsAddService.shared.addFriends(email: email) { responseData in
//            dump(responseData)
            switch responseData {
            case .success(let response):
                self.addButton.setImage(UIImage(named: "btn_add-friends_fin"), for: .normal)
            case .requestErr(let response):
                guard let response = response as? FriendsAddResponseModel else { return }
                if response.message != "" {
                    self.delegate?.friendsAddTVC(cell: self, resultMessage: response.message ?? "잘못된 요청입니다.")
                }
            case .pathErr:
                self.delegate?.friendsAddTVC(cell: self, resultMessage: "잘못된 요청입니다.")
                print("Path Error")
            case .serverErr:
                print("Server Error")
            case .networkFail:
                print("Network Fail")
            }
        }
    }
    
}
