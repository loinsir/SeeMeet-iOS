//
//  ProgressPlansCVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/12.
//

import UIKit
import SnapKit
import Then

class ProgressSendCVC: UICollectionViewCell {
        
    //Property
    private let cellHeadLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.text = "받은 요청"
    }
    private let dateAgoLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 13)
        $0.textColor = UIColor.grey04
        $0.text = "1일 전"
    }
    private let nameButton = UIButton().then{
        $0.backgroundColor = UIColor.black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    private let receiveLabel = UILabel().then{
        $0.text = "친구의 요청에 답해보세요!"
        $0.font = UIFont.hanSansRegularFont(ofSize: 16)
    }
   
    //MARK: Var
    static let identifier: String = "ProgressSendCVC"
    //MARK: setLayoutFunction
    
    func setLayout(){
        addSubviews([cellHeadLabel, dateAgoLabel, nameButton, receiveLabel])
        
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
        nameButton.snp.makeConstraints{
            $0.top.equalTo(cellHeadLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(63)
            $0.height.equalTo(26)
        }
        receiveLabel.snp.makeConstraints{
            $0.top.equalTo(nameButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(180)
            $0.height.equalTo(32)
        }
        
    }
    
    func setButtonTitle(){
        nameButton.setTitle("하이요", for: .normal)
    }
       
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        setButtonTitle()
        // Initialization code
    }
    
}
