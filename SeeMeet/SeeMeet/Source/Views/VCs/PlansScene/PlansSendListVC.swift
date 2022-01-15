//
//  PlansSendListVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/16.
//

import UIKit

class PlansSendListVC: UIViewController {
    
    private let collectionScrollView = UIScrollView().then{
        $0.isPagingEnabled = true
        $0.bounces = false
        $0.contentSize = CGSize(width: UIScreen.getDeviceWidth(), height: 0)
        $0.backgroundColor = UIColor.white
        $0.showsVerticalScrollIndicator = true
    }
    private let headerView = UIView().then{
        $0.backgroundColor = UIColor.grey01
    }
    private let backButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_back"), for: .normal)
    }
    private let headLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 24)
        $0.textColor = UIColor.grey06
        $0.attributedText = $0.setTextFontAttribute(defaultText: "약속을 확정해 주세요", containText: "약속을 확정", changingFont: UIFont.hanSansBoldFont(ofSize: 24), color: UIColor.grey06)
    }
    private let nameTagStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 0
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    private let confirmCountLabel = UILabel().then{
        $0.font = UIFont.dinProRegularFont(ofSize: 30)
        $0.textColor = UIColor.grey06
        $0.text = "3/3"
    }
    //보낸 신청 내용
    private let sendPlansDetailLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
        $0.text = "보낸 신청 내용"
        $0.textColor = UIColor.grey06
    }
    private let textView = UIView().then{
        $0.backgroundColor = UIColor.white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let titleLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.text = "대방어 데이"
    }
    private let titleBottomView = UIView().then{
        $0.backgroundColor = UIColor.grey06
    }
    private let detailTextView = UITextView().then{
        $0.text = "야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비"
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.textColor = UIColor.grey06
    }
    private let bottomView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let cancelButton = UIButton().then{
        $0.backgroundColor = UIColor.grey04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let confirmButton = UIButton().then{
        $0.backgroundColor = UIColor.grey02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
//MARK: setLayout
    func setHeadLayout() {
        view.addSubviews([headerView, headLabel, nameTagStackView, confirmCountLabel, textView, bottomView])
        headerView.addSubview(backButton)
        
        headerView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(102)
        }
        backButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(2)
            $0.top.equalToSuperview().offset(5)
            $0.width.height.equalTo(48)
        }
        headLabel.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(210)
            $0.height.equalTo(32)
        }
        nameTagStackView.snp.makeConstraints{
            $0.top.equalTo(headLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(205)
            $0.height.equalTo(26)
        }
        confirmCountLabel.snp.makeConstraints{
            $0.centerY.equalTo(nameTagStackView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(43)
            $0.height.equalTo(32)
        }
    }
    
    
    func setCellViewLayout(){
        
    }
    
    
    

}
