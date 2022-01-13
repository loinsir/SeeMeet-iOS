//
//  CompletePlansCVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/13.
//

import UIKit

class CompletePlansCVC: UICollectionViewCell {
    //MARK: component
    private let dateAgoLable = UILabel().then{
        $0.font = UIFont.dinProMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey04
    }
    private let cancelPlansButton = UIButton().then{
        $0.setTitleColor(UIColor.pink01, for: .normal)
        $0.setTitle("약속 취소", for: .normal)
    }
    private let closeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_close"), for: .normal)
    }
    private let plansNameLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
        $0.textColor = UIColor.black
    }
    private let plansNameButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_PlansName"), for: .normal)
    }
    private let nameTagButtonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 6
        $0.layoutMargins = UIEdgeInsets(top: 10 , left: 0 , bottom: 10 , right: 10 )
        $0.isLayoutMarginsRelativeArrangement = true
    }
    private let bottomView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    //MARK: function
    func setLayout(){
        addSubviews([dateAgoLable, cancelPlansButton, closeButton, plansNameLabel, plansNameButton, nameTagButtonStackView, bottomView])
        
        dateAgoLable.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(34)
        }
        cancelPlansButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(dateAgoLable.snp.trailing).offset(6)
            $0.width.equalTo(55)
            $0.height.equalTo(32)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.width.height.equalTo(48)
        }
        plansNameLabel.snp.makeConstraints{
            $0.top.equalTo(cancelPlansButton.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(90)
            $0.height.equalTo(32)
        }
        plansNameButton.snp.makeConstraints{
            $0.top.equalTo(cancelPlansButton.snp.bottom).offset(5)
            $0.leading.equalTo(plansNameLabel.snp.trailing).offset(0)
            $0.width.equalTo(24)
            $0.height.equalTo(32)
        }
        nameTagButtonStackView.snp.makeConstraints{
            $0.top.equalTo(plansNameLabel.snp.top).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(26)
            $0.width.equalTo(213)
        }
        bottomView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(1)
            
        }
    }
    //MARK:Var
    static let identifier: String = "CompletePlansCVC"
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        // Initialization code
    }

}
