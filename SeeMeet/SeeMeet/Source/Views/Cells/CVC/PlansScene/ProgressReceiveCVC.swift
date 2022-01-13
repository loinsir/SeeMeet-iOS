//
//  ProgressReceiveCVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/13.
//

import UIKit
import SwiftUI

class ProgressReceiveCVC: UICollectionViewCell {
    //MARK: component
    private let cellHeadLabel = UILabel().then{
           $0.font = UIFont.hanSansBoldFont(ofSize: 18)
           $0.textColor = UIColor.pink01
           $0.textAlignment = .center
           $0.text = "보낸 요청"
       }
       private let dateAgoLabel = UILabel().then{
           $0.font = UIFont.hanSansRegularFont(ofSize: 13)
           $0.textColor = UIColor.grey04
           $0.text = "1일 전"
       }
       private let sendLabel = UILabel().then{
           $0.font = UIFont.hanSansRegularFont(ofSize: 16)
           $0.textColor = UIColor.black
       }
       private let nameTagButtonStackView = UIStackView().then{
           $0.axis = .horizontal
           $0.alignment = .leading
           $0.distribution = .fillEqually
           $0.spacing = 6
           $0.layoutMargins = UIEdgeInsets(top: 10 , left: 0 , bottom: 10 , right: 10 )
           $0.isLayoutMarginsRelativeArrangement = true
       }
    //MARK: setLayout
    func setLayout(){
        addSubviews([cellHeadLabel, dateAgoLabel, nameTagButtonStackView, sendLabel])
        
        getShadowView(color: UIColor.grey04.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 3, shadowOpacity: 0.4)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.white
        
        cellHeadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(75)
            $0.height.equalTo(32)
        }
        dateAgoLabel.snp.makeConstraints{
            $0.centerY.equalTo(cellHeadLabel)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.equalTo(35)
            $0.height.equalTo(32)
        }
        sendLabel.snp.makeConstraints{
            $0.top.equalTo(cellHeadLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(240)
            $0.height.equalTo(32)
        }
        nameTagButtonStackView.snp.makeConstraints{
            $0.top.equalTo(sendLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(26)
            $0.width.equalTo(213)
        }
        getStackButton()
        setTextAttribute()
    }
    func setTextAttribute(){
        sendLabel.attributedText = sendLabel.setTextFontAttribute(defaultText: "친구 \(friendsCount)명의 답변을 기다리고 있어요!", containText: String(friendsCount), changingFont: UIFont.hanSansBoldFont(ofSize: 16), color: UIColor.pink01)
    }
    func getStackButton(){
        nameDummy.forEach {
            let nameButton: UIButton = UIButton()
            nameButton.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
            nameButton.setTitle($0, for: .normal)
            if isAccept == true{
                nameButton.setTitleColor(UIColor.white, for: .normal)
                nameButton.backgroundColor = UIColor.pink01
            }
            else{
                nameButton.setTitleColor(UIColor.pink01, for: .normal)
                nameButton.backgroundColor = UIColor.white
            }
            nameButton.clipsToBounds = true
            nameButton.layer.borderWidth = 1
            nameButton.layer.borderColor = UIColor.pink01.cgColor
            nameButton.layer.cornerRadius = 12
            nameTagButtonStackView.addArrangedSubview(nameButton)
            nameButton.snp.makeConstraints{
                $0.top.bottom.equalToSuperview().offset(0)
            }
        }
    }
    //MARK: Var
    static let identifier: String = "ProgressReceiveCVC"
    let friendsCount: Int = 2
    let nameDummy: [String] = ["가나다", "가나다", "가나다"]
    let isAccept: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        // Initialization code
    }

}
