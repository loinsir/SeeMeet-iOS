//
//  PlansRecieveCVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/15.
//

import UIKit
import SnapKit
import Then

class PlansReceiveCVC: UICollectionViewCell {
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 16)
        $0.textColor = UIColor.grey06
        $0.text = "대방어 데이"
    }
    private let bottomView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    private let sideView = UIView().then{
        $0.backgroundColor = UIColor.grey06
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    private let timeLabel = UILabel().then{
        $0.font = UIFont.dinProRegularFont(ofSize: 13)
        $0.textColor = UIColor.grey06
        $0.text = "오전 11:00 - 오후 2:00"
    }
    private let nameTagButtonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 6
        $0.layoutMargins = UIEdgeInsets(top: 4 , left: 0 , bottom: 4, right: 10 )
        $0.isLayoutMarginsRelativeArrangement = true
    }

    private func setLayout(){
        addSubviews([titleLabel, bottomView, sideView, timeLabel, nameTagButtonStackView])
        
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.white
        getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 1, shadowOpacity: 0.1)
        
        sideView.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview().offset(0)
            $0.width.equalTo(12)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(sideView.snp.trailing).offset(15)
            $0.height.equalTo(20)
        }
        bottomView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.equalTo(sideView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(1)
        }
        timeLabel.snp.makeConstraints{
            $0.top.equalTo(bottomView.snp.bottom).offset(11)
            $0.leading.equalTo(sideView.snp.trailing).offset(15)
            $0.height.equalTo(17)
        }
        nameTagButtonStackView.snp.makeConstraints{
            $0.top.equalTo(timeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(sideView.snp.trailing).offset(15)
            $0.width.equalTo(180)
            $0.height.equalTo(30)
        }
        
    }
    
   private func setStackButton(){
        nameDummy.forEach {
            let nameButton: UIButton = UIButton()
            nameButton.titleLabel?.font = UIFont.hanSansRegularFont(ofSize: 13)
            nameButton.setTitle($0, for: .normal)
            nameButton.setTitleColor(UIColor.pink01, for: .normal)
            nameButton.backgroundColor = UIColor.white
            nameButton.clipsToBounds = true
            nameButton.layer.borderWidth = 1
            nameButton.layer.borderColor = UIColor.pink01.cgColor
            nameButton.layer.cornerRadius = 12
            nameTagButtonStackView.addArrangedSubview(nameButton)
        }
    }
    //MARK: Var
    let nameDummy: [String] = ["김준희", "김준희", "김준희"]
    static let identifier: String = "PlansReceiveCVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        setStackButton()
        // Initialization code
    }

}
