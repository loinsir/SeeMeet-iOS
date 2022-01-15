import UIKit
import SwiftUI

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812
fileprivate let widthRatio = userWidth / 375

class FriendsAddTVC: UITableViewCell {
    
    // MARK: - properties
    
    static let identifier: String = "FriendsAddTVC"
    
    let profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "Ellipse_dummy")
    }
    
    let nameLabel: UILabel = UILabel().then {
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.black
        $0.text = "김준희"
    }
    
    let emailLabel: UILabel = UILabel().then {
        $0.font = UIFont.hanSansMediumFont(ofSize: 13)
        $0.textColor = UIColor.grey04
        $0.text = "joon13579@sookyung.ac.kr"
    }
    
    private let addButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_add-friends"), for: .normal)
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
        addButton.setImage(UIImage(named: "btn_add-friends_fin"), for: .normal)
    }
    
}
