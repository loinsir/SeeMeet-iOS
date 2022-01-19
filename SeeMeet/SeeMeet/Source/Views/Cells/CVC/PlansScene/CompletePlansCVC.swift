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
        $0.text = "1일전"
        $0.font = UIFont.dinProMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey04
    }
    private let cancelPlansButton = UIButton().then{
        $0.setTitleColor(UIColor.pink01, for: .normal)
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.setAttributedTitle(String.getAttributedText(text: "약속 취소", letterSpacing: -0.6, lineSpacing: nil), for: .normal)
    }
    private let closeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_close"), for: .normal)
    }
    private let plansNameLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
        $0.attributedText = String.getAttributedText(text: "강화도 여행", letterSpacing: -0.6, lineSpacing: nil)
        $0.textColor = UIColor.black
    }
    private let plansNameButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_plansName"), for: .normal)
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
            $0.height.equalTo(18)
            $0.width.equalTo(34)
        }
        cancelPlansButton.snp.makeConstraints{
            $0.centerY.equalTo(dateAgoLable)
            $0.leading.equalTo(dateAgoLable.snp.trailing).offset(6)
            $0.width.equalTo(55)
            $0.height.equalTo(18)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.width.height.equalTo(48)
        }
        plansNameLabel.snp.makeConstraints{
            $0.top.equalTo(cancelPlansButton.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(32)
        }
        plansNameButton.snp.makeConstraints{
            $0.top.equalTo(cancelPlansButton.snp.bottom).offset(5)
            $0.leading.equalTo(plansNameLabel.snp.trailing).offset(0)
            $0.width.equalTo(24)
            $0.height.equalTo(32)
        }
        nameTagButtonStackView.snp.makeConstraints{
            $0.top.equalTo(plansNameLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(26)
            $0.width.equalTo(213)
        }
        bottomView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(1)
        }
        
    }
    //MARK: function
    func getStackButton(){
        nameTagButtonStackView.removeAllSubViews()
        nameDummy.forEach {
            var i: Int = 0
            let nameButton: UIButton = UIButton()
            nameButton.setTitle($0, for: .normal)
            nameButton.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
            if isAccept[0] == true{
                nameButton.setTitleColor(UIColor.grey06, for: .normal)
                nameButton.backgroundColor = UIColor.grey02
            }
            else{
                nameButton.setTitleColor(UIColor.grey04, for: .normal)
                nameButton.backgroundColor = UIColor.white
                nameButton.layer.borderWidth = 1
                nameButton.layer.borderColor = UIColor.grey04.cgColor
            }
            nameButton.clipsToBounds = true
            nameButton.layer.cornerRadius = 12
            nameTagButtonStackView.addArrangedSubview(nameButton)
            nameButton.snp.makeConstraints{
                $0.top.bottom.equalToSuperview().offset(0)
            }
            i += 1
            if $0 == "" {
                nameButton.layer.borderWidth = 0
                nameButton.backgroundColor = .none
            }
        }
        plansNameLabel.attributedText = String.getAttributedText(text: plansTitle, letterSpacing: -0.6, lineSpacing: nil)
        
        if isConfirmData == true && isCanceldData == false{
            cancelPlansButton.setTitle("약속 확정", for: .normal)
        }
        else{
            cancelPlansButton.setTitle("약속 취소", for: .normal)
        }
        
        dateAgoLable.attributedText = String.getAttributedText(text: dDayagoText + "일전", letterSpacing: -0.6, lineSpacing: nil)
    }
    
    func setData(dDayago: String, plansName: String, isConfirm: Bool, isCanceled: Bool, nameList: [String], nameBoolList: [Bool]){
        nameDummy = nameList
        isAccept = nameBoolList
        isConfirmData = isConfirm
        isCanceldData = isCanceled
        dDayagoText = dDayago
        plansTitle = plansName
        
        setLayout()
        getStackButton()
    }
    
    
    //MARK:Var
    static let identifier: String = "CompletePlansCVC"
    var nameDummy: [String] = ["가나다", "가나다", "가나다"]
    var isAccept: [Bool] = [false, false, false]
    var isConfirmData: Bool = false
    var isCanceldData: Bool = false
    var dDayagoText: String = ""
    var plansTitle: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    



}
