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
        $0.addTarget(self, action: #selector(backButtonClicked(_:)), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(cancelButtonClicked(_:)), for: .touchUpInside)
    }
    private let confirmButton = UIButton().then{
        $0.backgroundColor = UIColor.grey02
        $0.setTitle("확정", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(accessButtonClicked(_:)), for: .touchUpInside)
    }
    //MARK: Var
    var dateCount: Int = 4
    var plansId: String = "0"
    var isChecked: Bool = false
    var cellChecked: Bool = false
    var checkedIndex: Int = 0
    var plansData: [PlansSendDetailData] = []
    var plansDate: [PlansSendInvitationDate] = []
    var nameDummy: [String] = ["김김김", "김김김", "김김김"]
    var cellNameDummy: [String] = ["아ㅋㅋ", "아ㅋㅋ", "아ㅋㅋ"]
    var nameBoolList: [Bool] = [false, false, false]
    var nameCount: Int = 0
    var profileCount: Int = 0
    var checkDataId: Int = 0
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlansData()
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
            $0.width.equalTo(250)
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
//            $0.top.equalTo(headLabel.snp.bottom).offset(22)
            $0.leading.equalTo(nameTagStackView.snp.trailing).offset(87)
            $0.width.equalTo(43)
            $0.height.equalTo(32)
        }
        setStackButton()
    }
    
    
    func setCellViewLayout(){
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
                        $0.text = plansDate[cellCount - 1].date
                        $0.textColor = UIColor.grey06
                    }
                    let centerView = UIView().then{
                        $0.backgroundColor = UIColor.grey04
                    }
                    let timeLabel = UILabel().then{
                        $0.font = UIFont.dinProMediumFont(ofSize: 16)
                        $0.textColor = UIColor.grey06
                        $0.text = setDateLabel(date: plansDate[cellCount-1].start) + " ~ " + setDateLabel(date: plansDate[cellCount-1].end)
                        $0.textAlignment = .left
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
                        $0.text = ""
                    }
                    cellbottomView.addSubviews([profileImageView, profileCount])
                    cellNameDummy = addCellGuest(guesList: plansDate[cellCount - 1].respondent)
                    var nameLabellMargin: Int = 0
                    cellNameDummy.forEach {
                        if $0 != "" {
                        let nameLabel = UILabel()
                        nameLabel.font = UIFont.hanSansRegularFont(ofSize: 13)
                        nameLabel.textColor = UIColor.grey05
                        nameLabel.text = $0
                        cellbottomView.addSubview(nameLabel)
                        nameLabel.snp.makeConstraints{
                            $0.trailing.equalToSuperview().offset(-16 + (nameLabellMargin * -64))
                            $0.centerY.equalToSuperview()
                            $0.width.equalTo(50)
                        }
                        profileImageView.snp.makeConstraints{
                            $0.top.equalToSuperview().offset(13)
                            $0.trailing.equalTo(profileCount.snp.leading).offset(-4)
                            $0.width.height.equalTo(13)
                        }
                        profileCount.snp.makeConstraints{
                            $0.centerY.equalTo(profileImageView)
                            $0.trailing.equalTo(nameLabel.snp.leading).offset(-17)
                            $0.width.equalTo(8)
                            $0.height.equalTo(18)
                        }
                        nameLabellMargin += 1
                        }
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
                    if nameLabellMargin == 0{
                        profileImageView.snp.makeConstraints{
                            $0.top.equalToSuperview().offset(13)
                            $0.trailing.equalTo(profileCount.snp.leading).offset(-4)
                            $0.width.height.equalTo(13)
                        }
                        profileCount.snp.makeConstraints{
                            $0.centerY.equalTo(profileImageView)
                            $0.trailing.equalToSuperview().offset(-22)
                            $0.width.equalTo(8)
                            $0.height.equalTo(18)
                        }
                    }
                    dateSelectBackgroundView.snp.updateConstraints{
                        $0.height.equalTo(cellCount * 115)
                    }
                    profileCount.text = String(plansDate[cellCount - 1].respondent.count)
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
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview().offset(18)
        }
        setBottomButtonView()
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
        var index: Int = 0
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
               if $0 == ""{
                   nameButton.layer.borderWidth = 0
                   nameButton.backgroundColor = .none
               }
               if nameBoolList[index] == true {
                   nameButton.backgroundColor = UIColor.pink01
                   nameButton.setTitleColor(UIColor.white, for: .normal)
               }
               nameTagStackView.addArrangedSubview(nameButton)
               index += 1
           }
       }
    
    func setData(){
        nameDummy = addGuest(guesList: plansData[0].invitation.guests)
        nameBoolList = addBoolGuest(guesList: plansData[0].invitation.guests)
        titleLabel.text = plansData[0].invitation.invitationTitle
        detailTextView.text = plansData[0].invitation.invitationDesc
        var cnt: [Int] = confirmCount(list: nameBoolList)
        confirmCountLabel.attributedText = confirmCountLabel.setTextFontColorSpacingAttribute(defaultText: "\(cnt[0])/\(cnt[1])", value: -0.6, containText: "\(cnt[0])", changingFont: UIFont.dinProBoldFont(ofSize: 30), color: UIColor.pink01)
        if cnt[0] == cnt[1] {
            headLabel.attributedText = headLabel.setTextFontColorSpacingAttribute(defaultText: "약속을 확정해 주세요", value: -0.6, containText: "약속을 확정", changingFont: UIFont.hanSansBoldFont(ofSize: 24), color: UIColor.grey06)
        }
        else{
            headLabel.attributedText = headLabel.setTextFontColorSpacingAttribute(defaultText: "답변을 기다리고 있어요", value: -0.6, containText: "답변", changingFont: UIFont.hanSansBoldFont(ofSize: 24), color: UIColor.grey06)
        }
    }
    
    func addGuest(guesList: [SendGuest]) -> [String]{
        var cnt: Int = 0
        var nameList: [String] = ["", "", ""]
        for guest in guesList{
            nameList[cnt] = guest.username
            cnt += 1
        }
        return nameList
    }
    func addCellGuest(guesList: [Host]) -> [String]{
        var cnt: Int = 0
        var nameList: [String] = ["", "", ""]
        for guest in guesList{
            nameList[cnt] = guest.username
            cnt += 1
        }
        if nameList == ["", "", ""] {
            return []
        }
        return nameList
    }
    func addBoolGuest(guesList: [SendGuest]) -> [Bool]{
        var cnt: Int = 0
        var boolList: [Bool] = [false, false, false]
        for guest in guesList{
            boolList[cnt] = guest.isResponse
            if guest.isResponse == true{
                nameCount += 1
            }
            cnt += 1
        }
        return boolList
    }
    func confirmCount(list: [Bool]) -> [Int]{
        var sol: [Int] = [0, 0]
        for obj in list{
            if obj == true {
                sol[0] += 1
            }
            else{
                sol[1] += 1
            }
        }
        return sol
    }
    func setDateLabel(date: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var changeDate = formatter.date(from: date) ?? Date()
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "a hh:mm"
        var returnDate = formatter2.string(from: changeDate)
        return returnDate
    }
    func getPlansData(){
        GetPlansSendDetailDataService.shared.getSendDetail(plansId: plansId){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? PlansSendDetailDataModel{
                           self.plansData.append(response.data)
                           self.plansDate = response.data.invitationDates
                           self.dateCount = self.plansDate.count
                           self.setData()
                           self.setHeadLayout()
                           self.setCellViewLayout()
                       }
                   case .requestErr(let message) :
                       print("requestERR")
                   case .pathErr :
                       print("pathERR")
                   case .serverErr:
                       print("serverERR")
                   case .networkFail:
                       print("networkFail")
                   }
               }
    }
    func postAcceptRequest(){
        PostPlansRequestAcceptService.shared.postPlansRequestAccept(plansId: plansId, dateId: checkDataId){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? PlansRequestAcceptDataModel{
                           print(response.status, response.message)
                       }
                   case .requestErr(let message) :
                       print("requestERR")
                   case .pathErr :
                       print("pathERR")
                   case .serverErr:
                       print("serverERR")
                   case .networkFail:
                       print("networkFail")
                   }
               }
    }
    func postCancelRequest(){
        PutInvitationCancelService.shared.putInvitationCancel(plansId: plansId){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? PlansRequestAcceptDataModel{
                           print(response.status, response.message)
                       }
                   case .requestErr(let message) :
                       print("requestERR")
                   case .pathErr :
                       print("pathERR")
                   case .serverErr:
                       print("serverERR")
                   case .networkFail:
                       print("networkFail")
                   }
               }
    }

    @objc private func accessButtonClicked(_ sender: UIButton){
        //타입은 서버처리 이후에 분기처리 해서 선택
        guard let confirmAlertVC = SMRequestPopUpVC(withType: .sendConfirm) as? SMRequestPopUpVC else {return}
        guard let notSelectAlertVC = SMRequestPopUpVC(withType: .sendNotSelectConfirm) as? SMRequestPopUpVC else {return}
        guard let notRequestAlertVC = SMRequestPopUpVC(withType: .sendNotRequestConfirm) as? SMRequestPopUpVC else {return}
        var cnt: [Int] = confirmCount(list: nameBoolList)

        var yearList: [String] = []
        var dateList: [String] = []
        checkDataId = plansDate[checkedIndex - 1].id
        yearList.append(plansDate[checkedIndex - 1].date)
        dateList.append(setDateLabel(date: plansDate[checkedIndex - 1].start) + " ~ " + setDateLabel(date: plansDate[checkedIndex - 1].end))
        
        print(yearList, dateList)
        
        if cnt[0] == cnt[1] {
            if cnt[1] < plansData[0].invitationDates[checkedIndex].respondent.count {
                notSelectAlertVC.modalPresentationStyle = .overFullScreen
                notSelectAlertVC.yearText = yearList
                notSelectAlertVC.dateText = dateList
                
                self.present(notSelectAlertVC, animated: false, completion: nil)
                
                notSelectAlertVC.pinkButtonCompletion = {
                    self.postAcceptRequest()
                    self.dismiss(animated: false, completion: nil)
                    let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.tabBarController?.tabBar.isHidden = false
                    self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: false)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toastMessage"), object: "약속을 확정했어요")
                }
            }
            else{
                confirmAlertVC.modalPresentationStyle = .overFullScreen
                confirmAlertVC.yearText = yearList
                confirmAlertVC.dateText = dateList

                self.present(confirmAlertVC, animated: false, completion: nil)
                
                    confirmAlertVC.pinkButtonCompletion = {
                        self.postAcceptRequest()
                        self.dismiss(animated: false, completion: nil)
                        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                        self.tabBarController?.tabBar.isHidden = false
                        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: false)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toastMessage"), object: "약속을 확정했어요")
                    }
            }
        }
        else {
            notRequestAlertVC.modalPresentationStyle = .overFullScreen
            notRequestAlertVC.yearText = yearList
            notRequestAlertVC.dateText = dateList
            
            self.present(notRequestAlertVC, animated: false, completion: nil)
            notRequestAlertVC.pinkButtonCompletion = {
                    notRequestAlertVC.pinkButtonCompletion = {
                        self.postAcceptRequest()
                        self.dismiss(animated: false, completion: nil)
                        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                        self.tabBarController?.tabBar.isHidden = false
                        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: false)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toastMessage"), object: "약속을 확정했어요")
                    }
                }
        }
        
     }
    @objc private func backButtonClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
     }
    @objc private func cancelButtonClicked(_ sender: UIButton){
        guard let AlertVC = SMPopUpVC(withType: .cancelPlans) as? SMPopUpVC else {return}
        AlertVC.modalPresentationStyle = .overFullScreen
        self.present(AlertVC, animated: false, completion: nil)
        
        AlertVC.pinkButtonCompletion = {
            self.postCancelRequest()
            self.dismiss(animated: true, completion: nil)
            let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: false)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toastMessage"), object: "약속을 취소했어요")
        }
     }
}

