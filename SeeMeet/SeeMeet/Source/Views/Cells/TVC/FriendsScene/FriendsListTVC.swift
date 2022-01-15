import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812
fileprivate let widthRatio = userWidth / 375

class FriendsListTVC: UITableViewCell {
    
    // MARK: - properties
    
    static let identifier: String = "FriendsListTVC"
    
    // 임시 프로필 뷰
    let profileIcon: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey03
    }
    
    let nameLabel: UILabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.text = "김준희"
    }
    
    let addMessageButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_add-message"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpAddMessageButton(_:)), for: .touchUpInside)
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
        addSubviews([profileIcon, nameLabel, addMessageButton])
        
        profileIcon.snp.makeConstraints {
            $0.width.height.equalTo(42 * heightRatio)
            $0.leading.centerY.equalToSuperview()
        }
        profileIcon.layer.cornerRadius = 20
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileIcon.snp.trailing).offset(18 * widthRatio)
            $0.centerY.equalToSuperview()
        }
        
        addMessageButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(48 * widthRatio)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func touchUpAddMessageButton(_ sender: UIButton) {
        
    }
    
}
