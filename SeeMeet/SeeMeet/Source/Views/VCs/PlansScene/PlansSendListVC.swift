//
//  PlansSendListVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/16.
//

import UIKit

class sendCellIndex: UITapGestureRecognizer {
    var cellView: UIView?
    var isChecked: Bool?
    var yearLabel: UILabel?
    var dateLabel: UILabel?
}

class PlansSendListVC: UIViewController {
    private let backGroundScrollView = UIScrollView().then{
        $0.isPagingEnabled = false
        $0.bounces = true
        $0.contentSize = CGSize(width: UIScreen.getDeviceWidth(), height: 1000)
        $0.backgroundColor = UIColor.grey01
        $0.showsVerticalScrollIndicator = true
        $0.contentInsetAdjustmentBehavior = .never
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
        $0.spacing = 10
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    private let confirmCountLabel = UILabel().then{
        $0.font = UIFont.dinProRegularFont(ofSize: 30)
        $0.textColor = UIColor.grey06
        $0.text = "3/3"
    }
    private var dateSelectBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
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
        $0.backgroundColor = UIColor.grey02
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
        $0.setTitle("취소", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let confirmButton = UIButton().then{
        $0.backgroundColor = UIColor.grey02
        $0.setTitle("확정", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    //MARK: Var
    var dateCount: Int = 4
    var isChecked: Bool = false
    var cellChecked: Bool = false
    var checkedIndex: Int = 0
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeadLayout()
        setCellViewLayout()
    }
//MARK: setLayout
    func setHeadLayout() {
        view.addSubviews([headerView, backGroundScrollView])
        headerView.addSubview(backButton)
        backGroundScrollView.addSubviews([headLabel, nameTagStackView, confirmCountLabel, sendPlansDetailLabel, textView, bottomView, dateSelectBackgroundView])
        headerView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(102)
        }
        backButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(2)
            $0.top.equalToSuperview().offset(49)
            $0.width.height.equalTo(48)
        }
        backGroundScrollView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        headLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
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
            $0.top.equalTo(headLabel.snp.bottom).offset(22)
            $0.leading.equalTo(nameTagStackView.snp.trailing).offset(87)
            $0.width.equalTo(43)
            $0.height.equalTo(32)
        }
        setStackButton()
    }
    
    
    func setCellViewLayout(){
        var nameDummy: [String] = ["아ㅋㅋ", "아ㅋㅋ", "아ㅋㅋ"]
        //서버통신후 수정,,,
        dateSelectBackgroundView.snp.makeConstraints{
            $0.top.equalTo(nameTagStackView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(99)
        }
                for cellCount in 1 ... dateCount {
                    let yearLabel = UILabel().then{
                        $0.font = UIFont.dinProBoldFont(ofSize: 18)
                        $0.text = "2021.12.23"
                        $0.textColor = UIColor.grey06
                    }
                    let centerView = UIView().then{
                        $0.backgroundColor = UIColor.grey04
                    }
                    let timeLabel = UILabel().then{
                        $0.font = UIFont.dinProMediumFont(ofSize: 16)
                        $0.textColor = UIColor.grey06
                        $0.text = "오전 11:00 ~ 오후 04:00"
                    }
                    let cellbottomView = UIView().then{
                        $0.backgroundColor = UIColor.white
                        $0.clipsToBounds = true
                        $0.layer.cornerRadius = 10
                        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                    }
                    let cellBackgroundView = UIView().then{
                        let tapGesture = sendCellIndex(target: self, action: #selector(cellClicked(gesture:)))
                        $0.addGestureRecognizer(tapGesture)
                        $0.isUserInteractionEnabled = true
                        tapGesture.cellView = $0
                        tapGesture.isChecked = false
                        $0.backgroundColor = UIColor.grey02
                        $0.clipsToBounds = true
                        $0.layer.cornerRadius = 10
                        $0.addSubviews([yearLabel, centerView, timeLabel, cellbottomView])
                        tapGesture.yearLabel = yearLabel
                        tapGesture.dateLabel = timeLabel
                    }
                    dateSelectBackgroundView.addSubview(cellBackgroundView)
                    cellBackgroundView.tag = cellCount
                    
                    
                    let profileImageView = UIImageView().then{
                        $0.image = UIImage(named: "ic_friend")
                    }
                    let profileCount = UILabel().then{
                        $0.font = UIFont.hanSansRegularFont(ofSize: 13)
                        $0.textColor = UIColor.grey03
                        $0.text = "3"
                    }
                    let nameStackView = UIStackView().then{
                        $0.axis = .horizontal
                        $0.alignment = .fill
                        $0.distribution = .fillEqually
                        $0.spacing = 0
                        $0.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                        $0.isLayoutMarginsRelativeArrangement = true
                    }
                    cellbottomView.addSubviews([profileImageView, profileCount, nameStackView])
                    nameDummy.forEach {
                        let nameLabel = UILabel()
                        nameLabel.font = UIFont.hanSansRegularFont(ofSize: 13)
                        nameLabel.textColor = UIColor.grey05
                        nameLabel.text = $0
                        nameStackView.addArrangedSubview(nameLabel)
                    }
                    cellBackgroundView.snp.makeConstraints{
                        $0.top.equalToSuperview().offset((cellCount - 1) * 115)
                        $0.leading.equalToSuperview().offset(0)
                        $0.trailing.equalToSuperview().offset(0)
                        $0.height.equalTo(99)
                    }
                    yearLabel.snp.makeConstraints{
                        $0.top.equalToSuperview().offset(17)
                        $0.leading.equalToSuperview().offset(22)
                        $0.width.equalTo(90)
                    }
                    centerView.snp.makeConstraints{
                        $0.top.equalToSuperview().offset(18)
                        $0.leading.equalTo(yearLabel.snp.trailing).offset(18)
                        $0.width.equalTo(1)
                        $0.height.equalTo(22)
                    }
                    timeLabel.snp.makeConstraints{
                        $0.top.equalToSuperview().offset(17)
                        $0.leading.equalTo(centerView.snp.trailing).offset(17)
                        $0.height.equalTo(21)
                    }
                    cellbottomView.snp.makeConstraints{
                        $0.bottom.leading.trailing.equalToSuperview().offset(0)
                        $0.height.equalTo(41)
                    }
                    profileImageView.snp.makeConstraints{
                        $0.top.equalToSuperview().offset(13)
                        $0.leading.equalToSuperview().offset(131)
                        $0.width.height.equalTo(13)
                    }
                    profileCount.snp.makeConstraints{
                        $0.centerY.equalTo(profileImageView)
                        $0.leading.equalTo(profileImageView.snp.trailing).offset(4)
                        $0.width.equalTo(8)
                        $0.height.equalTo(18)
                    }
                    nameStackView.snp.makeConstraints{
                        $0.centerY.equalTo(profileCount)
                        $0.leading.equalTo(profileCount).offset(16)
                        $0.width.equalTo(124)
                        $0.height.equalTo(20)
                    }
                    dateSelectBackgroundView.snp.updateConstraints{
                        $0.height.equalTo(cellCount * 115)
                    }
                }
        setTextViewLayout()
    }
    func setTextViewLayout(){
        textView.addSubviews([titleLabel, titleBottomView, detailTextView])
        sendPlansDetailLabel.snp.makeConstraints{
            $0.top.equalTo(dateSelectBackgroundView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(35)
        }
        textView.snp.makeConstraints{
            $0.top.equalTo(sendPlansDetailLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(255)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(25)
            $0.height.equalTo(32)
            $0.width.equalTo(295)
        }
        titleBottomView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(1)
        }
        detailTextView.snp.makeConstraints{
            $0.top.equalTo(titleBottomView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview().offset(18)
        }
        setBottomButtonView()
        print(backGroundScrollView.frame)
    }
    func setBottomButtonView() {
        bottomView.addSubviews([cancelButton, confirmButton])
        bottomView.snp.makeConstraints{
            $0.top.equalTo(textView.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing).offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.height.equalTo(112)
        }
        print(backGroundScrollView.frame)
        cancelButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(160)
            $0.height.equalTo(54)
            
        }
        confirmButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.width.equalTo(160)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(54)
        }
    }
    //MARK: function
    @objc private func cellClicked(gesture: sendCellIndex){
        print(gesture.cellView?.tag)
        if isChecked == false {
            isChecked = true
            if gesture.isChecked == false{
                gesture.isChecked = true
                gesture.cellView?.backgroundColor = UIColor.black
                gesture.yearLabel?.textColor = UIColor.white
                gesture.dateLabel?.textColor = UIColor.white
                gesture.cellView?.layer.borderWidth = 1
                gesture.cellView?.layer.borderColor = UIColor.black.cgColor
                checkedIndex = gesture.cellView?.tag ?? 0
                confirmButton.backgroundColor = UIColor.pink01
            }
        }
        else{
            if gesture.isChecked == true{
                gesture.isChecked = false
                isChecked = false
                gesture.cellView?.backgroundColor = UIColor.grey02
                gesture.cellView?.layer.borderWidth = 0
                gesture.yearLabel?.textColor = UIColor.grey06
                gesture.dateLabel?.textColor = UIColor.grey06
                checkedIndex = gesture.cellView?.tag ?? 0
                confirmButton.backgroundColor = UIColor.grey02
            }
        }
    }
    func setStackButton(){
        let nameDummy: [String] = ["김김김", "김김김", "김김김"]
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
               nameTagStackView.addArrangedSubview(nameButton)
           }
       }
}

