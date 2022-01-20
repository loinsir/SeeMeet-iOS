//
//  PlansReceiveVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/14.
//

import UIKit
import SnapKit
import Then

//셀 tag받아올라고 custom
class cellIndexAction: UITapGestureRecognizer {
    var viewTag: Int = 0
    var isChecked: Bool?
    var button: UIButton?
}

class PlansReceiveVC: UIViewController {

    //MARK: Component
    //titleComponent
    private let backgroundView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let backGroundScrollView = UIScrollView().then{
        $0.backgroundColor = UIColor.white
        $0.isPagingEnabled = false
        $0.bounces = true
        $0.showsVerticalScrollIndicator = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let headerBackgroundView = UIView().then{
        $0.backgroundColor = .none
    }
    private let backButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_back"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked(_:)), for: .touchUpInside)
    }
    private let titleLabel = UILabel().then{
        $0.textColor = UIColor.orange
        $0.font = UIFont.hanSansBoldFont(ofSize: 14)
        $0.attributedText = $0.setTextLineAttribute(defaultText: "새로운 초대장", value: -0.6)
    }
    private let nameTitleLabel = UILabel().then{
        $0.textColor = UIColor.grey06
        $0.font = UIFont.hanSansRegularFont(ofSize: 24)
        $0.text = "김준희님이 보냈어요"
    }
    private let titleImageView = UIImageView().then{
        $0.image = UIImage(named: "img_illust_11")
    }
    //textView
    private let textBackGroundView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let plansTitleLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .left
        $0.text = "대방어 데이"
    }
    private let textBottomView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    private let plansDetailTextView = UITextView().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.backgroundColor = .none
        $0.textAlignment = .left
        $0.text = "야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비워놔라 야그들아 대방어먹게 시간 비워놔라야그들아 대방어먹게 시간 비"
    }
    private let withRecieveLabel = UILabel().then{
        $0.attributedText = $0.setTextLineAttribute(defaultText: "나와 함께 받은 사람", value: -0.6)
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.grey06
    }
    private let nameTagButtonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 6
        $0.layoutMargins = UIEdgeInsets(top: 4 , left: 0 , bottom: 4, right: 10 )
        $0.isLayoutMarginsRelativeArrangement = true
    }
    private let withReciveBottomView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    //selectDate
    private let selectDateBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let selectDateHeadLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 20)
        $0.numberOfLines = 2
        $0.attributedText =  $0.setTextFontColorSpacingAttribute(defaultText: "내 일정과 비교하며\n날짜를 선택해보세요!", value: -0.6, containText: "날짜를 선택", changingFont: UIFont.hanSansBoldFont(ofSize: 20), color: UIColor.pink01)
    }
    //cell
    let sideView = UIView().then{
        $0.backgroundColor = UIColor.grey06
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 2
    }
    var checkButton = UIButton()
    //detail for selectDate
    private let detailBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.grey01
    }
    private let detailCollectionHeadLabel = UILabel().then{
        $0.font = UIFont.dinProBoldFont(ofSize: 20)
        $0.text = "2021.01.14"
    }
    private var detailSelectDateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.setCollectionViewLayout(layout, animated: false)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = .none
        $0.isPagingEnabled = false
        $0.bounces = true
        $0.showsHorizontalScrollIndicator = false
    }
    //bottomButtonView
    private let bottomButtonBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let bottomDenineButton = UIButton().then{
        $0.backgroundColor = UIColor.grey04
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.setTitle("거절", for: .normal)
        $0.addTarget(self, action: #selector(dinineButtonClicked(_:)), for: .touchUpInside)
    }
    private let bottomAcceptButton = UIButton().then{
        $0.backgroundColor = UIColor.pink01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.setTitle("답변", for: .normal)
        $0.addTarget(self, action: #selector(accessButtonClicked(_:)), for: .touchUpInside)
    }
    //emptyView
    private let emptyLabel = UILabel().then{
        $0.attributedText = String.getAttributedText(text: "일정이 없어요!", letterSpacing: -0.6, lineSpacing: nil)
        $0.textColor = UIColor.grey04
    }
    //MARK: setLayout
    func addView(){
        view.addSubviews([backGroundScrollView, headerBackgroundView])
        headerBackgroundView.addSubview(backButton)
        backGroundScrollView.addSubviews([titleLabel, nameTitleLabel, titleImageView, textBackGroundView, withRecieveLabel, nameTagButtonStackView, withReciveBottomView,selectDateBackgroundView, detailBackgroundView, bottomButtonBackgroundView])
        textBackGroundView.addSubviews([plansTitleLabel, textBottomView, plansDetailTextView])
        selectDateBackgroundView.addSubview(selectDateHeadLabel)
        detailBackgroundView.addSubviews([detailCollectionHeadLabel, detailSelectDateCollectionView])
        bottomButtonBackgroundView.addSubviews([bottomDenineButton, bottomAcceptButton])
        
        backGroundScrollView.isScrollEnabled = true
        plansDetailTextView.isScrollEnabled = true
        
    }
    func setHeadLayout(){
        headerBackgroundView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(102)
        }
        backButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(49)
            $0.leading.equalToSuperview().offset(2)
            $0.width.height.equalTo(48)
        }
        backGroundScrollView.contentSize = CGSize(width: userWidth, height: 0)
        backGroundScrollView.snp.makeConstraints{
            $0.top.equalTo(headerBackgroundView.snp.bottom).offset(0)
            $0.leading.bottom.trailing.equalToSuperview().offset(0)
        }
    }
    func setTextViewLayout() {
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(29)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(18)
        }
        nameTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(205)
        }
        titleImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing).offset(-31)
            $0.width.equalTo(107)
            $0.height.equalTo(81)
        }
        textBackGroundView.snp.makeConstraints{
            $0.top.equalTo(nameTitleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(255)
        }
        plansTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalTo(view.snp.trailing).offset(-15)
            $0.height.equalTo(32)
        }
        textBottomView.snp.makeConstraints{
            $0.top.equalTo(plansTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(view.snp.trailing).offset(-15)
            $0.height.equalTo(1)
        }
        plansDetailTextView.snp.makeConstraints{
            $0.top.equalTo(textBottomView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.bottom.equalToSuperview().offset(-18)
        }
        withRecieveLabel.snp.makeConstraints{
            $0.top.equalTo(textBackGroundView.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(19)
        }
        nameTagButtonStackView.snp.makeConstraints{
            $0.top.equalTo(withRecieveLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(188)
            $0.height.equalTo(32)
        }
        withReciveBottomView.snp.makeConstraints{
            $0.top.equalTo(nameTagButtonStackView.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(1)
        }
    }
    func setSelectData(){
        selectDateBackgroundView.snp.makeConstraints{
            $0.top.equalTo(withReciveBottomView.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing).offset(0)
            $0.height.equalTo(120 + (dateCount * 81))
            $0.width.equalTo(userWidth)
            if isFinished == true{
                $0.bottom.equalToSuperview()
            }
        }
        selectDateHeadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(37)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(180)
            $0.height.equalTo(52)
        }
        if isFinished == false{
            setDetailData()
        }
    }
    func setDetailData(){
        detailSelectDateCollectionView.delegate = self
        detailSelectDateCollectionView.dataSource = self
        detailSelectDateCollectionView.registerCustomXib(xibName: "PlansReceiveCVC")
        detailBackgroundView.addSubview(emptyLabel)
        
        detailBackgroundView.snp.makeConstraints{
            $0.top.equalTo(selectDateBackgroundView.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing)
            $0.width.equalTo(userWidth)
            $0.height.equalTo(261)
        }
        emptyLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
        emptyLabel.isHidden = true
        detailCollectionHeadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(26)
            $0.width.equalTo(100)
        }
        detailSelectDateCollectionView.snp.makeConstraints{
            $0.top.equalTo(detailCollectionHeadLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(135)
        }
        if isFinished == false{
            setBottomButtonViewLayout()
        }
    }
    func setBottomButtonViewLayout(){
        bottomButtonBackgroundView.snp.makeConstraints{
            $0.top.equalTo(detailBackgroundView.snp.bottom).offset(0)
            $0.leading.bottom.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(112)
            $0.bottom.equalToSuperview().offset(34)
        }
        bottomDenineButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(20)
            $0.height.equalTo(54)
            $0.width.equalTo(160)
        }
        bottomAcceptButton.snp.makeConstraints{
            $0.centerY.equalTo(bottomDenineButton)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(54)
            $0.width.equalTo(160)
        }
    }
    func setSelectDateCellLayout(){
        //서버통신후 수정,,,
        for cellCount in 1 ... dateCount {
            let selectCellView = UIView().then{
                let tapGesture = cellIndexAction(target: self, action: #selector(cellClicked(gesture:)))
                $0.isUserInteractionEnabled = true
                $0.tag = cellCount
                tapGesture.viewTag = $0.tag
                $0.addGestureRecognizer(tapGesture)
                $0.backgroundColor = UIColor.white
            }
            let yearLabel = UILabel().then{
                $0.font = UIFont.dinProBoldFont(ofSize: 16)
                $0.textColor = UIColor.grey06
                $0.text = plansDate[cellCount-1].date
            }
            let timeLabel = UILabel().then{
                $0.font = UIFont.dinProRegularFont(ofSize: 14)
                $0.textColor = UIColor.grey06
                $0.text = setDateLabel(date: plansDate[cellCount-1].start) + " ~ " + setDateLabel(date: plansDate[cellCount-1].end)
//                $0.text = "오전 11:00 ~ 오후 04:00"
            }
            checkButton = UIButton().then{
                $0.tag = cellCount
                if isFinished == true{
                    if isChecked[cellCount - 1] == true{
                        $0.setImage(UIImage(named: "ic_finish_check_inactive"), for: .normal)
                    }
                    else{
                        $0.setImage(UIImage(named: "ic_check_grey"), for: .normal)
                    }
                }
                else{
                    if isChecked[cellCount - 1] == true{
                        $0.setImage(UIImage(named: "ic_check_active"), for: .normal)
                    }
                    else{
                        $0.setImage(UIImage(named: "ic_check_grey"), for: .normal)
                    }
                }
                let tapGesture = cellIndexAction(target: self, action: #selector(cellCheckButtonClicked(gesture:)))
                $0.isUserInteractionEnabled = true
                tapGesture.viewTag = $0.tag
                tapGesture.button = $0
                $0.addGestureRecognizer(tapGesture)
            }
            let cellBottomView = UIView().then{
                $0.backgroundColor = UIColor.grey01
            }
            selectDateBackgroundView.addSubview(selectCellView)
            selectCellView.addSubviews([yearLabel, timeLabel, checkButton, cellBottomView])
            selectCellView.snp.makeConstraints{
                $0.top.equalToSuperview().offset(38 + (cellCount * 81))
                $0.leading.equalToSuperview().offset(0)
                $0.trailing.equalTo(view.snp.trailing).offset(0)
                $0.height.equalTo(81)
            }
            yearLabel.snp.makeConstraints{
                $0.top.equalToSuperview().offset(14)
                $0.leading.equalToSuperview().offset(40)
                $0.height.equalTo(21)
            }
            timeLabel.snp.makeConstraints{
                $0.top.equalTo(yearLabel.snp.bottom).offset(7)
                $0.leading.equalToSuperview().offset(40)
                $0.height.equalTo(18)
            }
            checkButton.snp.makeConstraints{
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(view.snp.trailing).offset(-11)
                $0.width.height.equalTo(48)
            }
            cellBottomView.snp.makeConstraints{
                $0.bottom.equalToSuperview().offset(0)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalTo(view.snp.trailing).offset(-20)
                $0.height.equalTo(1)
            }
            
        }
        if isFinished == false{
            selectDateBackgroundView.addSubview(sideView)
            sideView.snp.makeConstraints{
                $0.top.equalToSuperview().offset(114)
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalTo(4)
                $0.height.equalTo(86)
            }
        }
    }
    
    //MARK: Var
    let userHeigth: Int = UIScreen.getDeviceHeight()
    let userWidth: Int = UIScreen.getDeviceWidth()
    var nameDummy: [String] = ["하이루", "바이루"]
    var dateCount: Int = 4
    var cellIndex: Int = 1
    var isFinished: Bool = false
    var isChecked: [Bool] = [false, false, false, false]
    var plansId: String = "0"
    var plansData: [PlansDetailData] = []
    var plansDate: [PlansInvitationDate] = []
    var collectionData: [ResponseDateData] = []
    var collectionCellCount: Int = 0
    
    //Function
    func setStackButton(){
        var i: Int = 0
        nameDummy.forEach {
            let nameButton: UIButton = UIButton()
            nameButton.titleLabel?.font = UIFont.hanSansRegularFont(ofSize: 13)
            nameButton.setTitle($0, for: .normal)
            nameButton.setTitleColor(UIColor.pink01, for: .normal)
            nameButton.backgroundColor = UIColor.white
            nameButton.clipsToBounds = true
            nameButton.layer.borderWidth = 1
            if nameDummy[0] == ""{
                nameButton.layer.borderWidth = 0
            }
            nameButton.layer.borderColor = UIColor.pink01.cgColor
            nameButton.layer.cornerRadius = 12
            nameTagButtonStackView.addArrangedSubview(nameButton)
        }
    }
    @objc private func cellClicked(gesture: cellIndexAction){
        if isFinished == false{
            cellIndex = gesture.viewTag ?? 0
            UIView.animate(withDuration: 0.5){
                let yFrame = CGAffineTransform(translationX: 0, y: CGFloat(81 * (self.cellIndex - 1)))
                self.sideView.transform = yFrame
            }
        }
        setCVData()
        getTodayData()
     }
    @objc private func cellCheckButtonClicked(gesture: cellIndexAction){
        if isFinished == false{
            var index = gesture.viewTag - 1
            if isChecked[index] == false {
                gesture.button?.setImage(UIImage(named: "ic_check_active"), for: .normal)
                isChecked[index] = true
            }
            else{
                gesture.button?.setImage(UIImage(named: "ic_check_grey"), for: .normal)
                isChecked[index] = false
            }
            print("\(index+1)", isChecked[index])
        }
     }
    
    @objc private func accessButtonClicked(_ sender: UIButton){
        guard let requestAlertVC = SMRequestPopUpVC(withType: .recieveConfirm) as? SMRequestPopUpVC else {return}
        requestAlertVC.modalPresentationStyle = .overFullScreen
        self.present(requestAlertVC, animated: false, completion: nil)
     }
    @objc private func dinineButtonClicked(_ sender: UIButton){
        guard let AlertVC = SMPopUpVC(withType: .dismissRequest) as? SMPopUpVC else {return}
        AlertVC.modalPresentationStyle = .overFullScreen
        self.present(AlertVC, animated: false, completion: nil)
     }
    @objc private func backButtonClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
     }
    func addGuest(guesList: [PlansGuest]) -> [String]{
        var cnt: Int = 0
        var nameList: [String] = ["", "", ""]
        for guest in guesList{
            nameList[cnt] = guest.username
            cnt += 1
        }
        return nameList
    }
    func addCVGuest(guesList: [ResponseUser]) -> [String]{
        var cnt: Int = 0
        var nameList: [String] = ["", "", ""]
        for guest in guesList{
            nameList[cnt] = guest.username
            cnt += 1
        }
        return nameList
    }
    func setData(){
        nameTitleLabel.attributedText = nameTitleLabel.setTextFontColorSpacingAttribute(defaultText: "ㅇㅇㅇ님이 보냈어요", value: -0.6, containText: "ㅇㅇㅇ님", changingFont: UIFont.hanSansBoldFont(ofSize: 24), color: UIColor.grey06)
        plansTitleLabel.attributedText = plansTitleLabel.setTextLineAttribute(defaultText: plansData[0].invitation.invitationTitle, value: -0.6)
        plansDetailTextView.attributedText = String.getAttributedText(text: plansData[0].invitation.invitationDesc, letterSpacing: -0.6, lineSpacing: 24)
        nameDummy = addGuest(guesList: plansData[0].guests)
        dateCount = plansData[0].invitationDates.count
    }
    func setCVData(){
        detailCollectionHeadLabel.attributedText = detailCollectionHeadLabel.setTextLineAttribute(defaultText: plansDate[cellIndex-1].date, value: -0.6)
    }
    
    func getPlansData(){
        GetPlansDetailDataService.shared.getPlansDetail(postID: plansId){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? PlansDetailDataModel{
                           self.plansData.append(response.data)
                           self.plansDate = self.plansData[0].invitationDates
                           self.dateCount = self.plansData[0].invitationDates.count
                           self.addView()
                           self.setHeadLayout()
                           self.setTextViewLayout()
                           self.setSelectData()
                           self.setSelectDateCellLayout()
                           self.setData()
                           self.setStackButton()
                           self.getTodayData()
                           self.setCVData()
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
    func getTodayData(){
        GetResponseDateDataService.shared.getResponseDate(date: String(51)){ (response) in
            //String(plansData[0].invitationDates[cellIndex-1].id)
            print(String(self.plansData[0].invitationDates[self.cellIndex-1].id))
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? ResponseDateDataModel{
                           self.collectionData = response.data
                           self.collectionCellCount = self.collectionData.count
                           self.detailSelectDateCollectionView.reloadData()
                           if self.collectionCellCount == 0 {
                               self.emptyLabel.isHidden = false
                           }
                           else {
                               self.emptyLabel.isHidden = true
                           }
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
    func setDateLabel(date: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var changeDate = formatter.date(from: date) ?? Date()
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "a hh:mm"
        var returnDate = formatter2.string(from: changeDate)
        return returnDate
    }
    func setEmptyView(){
        if collectionCellCount == 0{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlansData()
    }
    
}

extension PlansReceiveVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 224.0, height: 129.0)
    }
}
extension PlansReceiveVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PlansReceiveCVC.identifier, for: indexPath) as! PlansReceiveCVC
        cell.setDate(title: collectionData[indexPath.row].invitationTitle, time: setDateLabel(date: collectionData[indexPath.row].start) + " ~ " + setDateLabel(date: collectionData[indexPath.row].end), nameList: addCVGuest(guesList: collectionData[indexPath.row].users))
        return cell
    }
    
    
}
extension PlansReceiveVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}
