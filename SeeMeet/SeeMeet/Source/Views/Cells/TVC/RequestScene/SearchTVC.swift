//
//  searchTVC.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/14.
//

import UIKit
import Then
import SnapKit

class SearchTVC: UITableViewCell {
    static let identifier: String = "SearchTVC"
    var name: String = ""
    
    
    private let profileImageView: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "img_profile")
    }
    private let nameLabel: UILabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        setLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private func addContentView(){
        addSubviews([profileImageView,nameLabel])
    }
    
    func setLayout(){
        profileImageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
            
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(18)
            $0.centerY.equalToSuperview()
        }

    }
    func setData(name: String){
        nameLabel.text = name
    }

}
