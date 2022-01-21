import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 821
fileprivate let widthRatio = userWidth / 375

class CalendarDetailVC: UIViewController {
    
    // MARK: - properties
    
    static let identifier: String = "CalendarDetailVC"
    
    private let topView: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey06
    }
    
    private let backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_back_white"), for: .normal)
        $0.addTarget(self, action: #selector(touchBackButton(_:)), for: .touchUpInside)
    }
    
    let navigationTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18.0)
        $0.textAlignment = .center
        $0.textColor = UIColor.white
    }
    
    let eventTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22.0)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
    }
    
    let timeLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "DINPro-Regular", size: 18.0)
        $0.textColor = UIColor.grey06
    }
    
    private let nameTagStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 10
        $0.layoutMargins = UIEdgeInsets(top: 10 * heightRatio, left: 10 * widthRatio, bottom: 10 * heightRatio, right: 10 * widthRatio)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    var planID: Int?
    
    private var possibleNameList: [String] = []
    private var impossibleNameList: [String] = []
    
    private let separator: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey02
    }
    
    private let letterView: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let letterTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        $0.textColor = UIColor.grey06
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private let letterSeparator: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey02
    }
    
    let letterContentView: UITextView = UITextView().then {
        $0.isEditable = false
        $0.backgroundColor = UIColor.clear
        $0.textColor = UIColor.grey06
        $0.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        
        $0.textContainerInset = UIEdgeInsets(top: 10 * heightRatio, left: 10 * widthRatio, bottom: 10 * heightRatio, right: 10 * widthRatio)
    }
    
    private let organizerLabel: UILabel = UILabel().then {
        $0.text = "약속 주최자"
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        $0.textColor = UIColor.grey04
    }
    
    private let divider: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey04
    }
    
    let organizerNameLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
    }
    
    private let bottomSeparator: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey02
    }
    
    private let deleteButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor.grey04
        $0.setTitle("약속 삭제", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        
        $0.addTarget(self, action: #selector(touchDeleteButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        requestPlanDetail()
    }
    
    // MARK: - methods
    
    private func setLayouts() {

        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            if UIScreen.hasNotch {
                $0.height.equalTo(102 * heightRatio)
            } else {
                $0.height.equalTo(CGFloat(58 + UIScreen.getIndecatorHeight()) * heightRatio)
            }
        }
        
        topView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.height.width.equalTo(48 * heightRatio)
            $0.leading.equalToSuperview().offset(2 * heightRatio)
            $0.bottom.equalToSuperview().offset(-5 * heightRatio)
        }
        
        topView.addSubview(navigationTitleLabel)
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(32 * heightRatio)
            $0.bottom.equalToSuperview().offset(-11 * heightRatio)
        }
        
        view.addSubview(eventTitleLabel)
        eventTitleLabel.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(33 * heightRatio)
            $0.leading.equalToSuperview().offset(21 * widthRatio)
            $0.trailing.equalToSuperview().offset(-37 * widthRatio)
        }
        
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(eventTitleLabel.snp.leading)
            $0.top.equalTo(eventTitleLabel.snp.bottom).offset(6 * heightRatio)
        }
        
        view.addSubview(nameTagStackView)
        nameTagStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10 * widthRatio)
            $0.top.equalTo(timeLabel.snp.bottom).offset(20 * heightRatio)
            $0.height.equalTo(46 * heightRatio)
        }
        
        view.addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(nameTagStackView.snp.bottom).offset(18.5 * heightRatio)
        }
        
        view.addSubview(letterView)
        letterView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20 * widthRatio)
            $0.trailing.equalToSuperview().offset(-20 * widthRatio)
            $0.top.equalTo(separator.snp.bottom).offset(25 * heightRatio)
            $0.height.equalTo(225 * heightRatio)
        }
        
        letterView.addSubview(letterTitleLabel)
        letterTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15 * heightRatio)
            $0.leading.equalToSuperview().offset(19 * widthRatio)
            $0.trailing.equalToSuperview().offset(-15 * widthRatio)
            $0.height.equalTo(32 * heightRatio)
        }
        
        letterView.addSubview(letterSeparator)
        letterSeparator.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15 * widthRatio)
            $0.trailing.equalToSuperview().offset(-15 * widthRatio)
            $0.height.equalTo(1)
            $0.top.equalTo(letterTitleLabel.snp.bottom).offset(9 * heightRatio)
        }
  
        letterView.addSubview(letterContentView)
        letterContentView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(9 * widthRatio)
            $0.top.equalTo(letterSeparator.snp.bottom).offset(3 * heightRatio)
            $0.trailing.equalToSuperview().offset(-5 * widthRatio)
            $0.bottom.equalToSuperview().offset(-8 * heightRatio)
        }
        
        view.addSubview(organizerLabel)
        organizerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25 * widthRatio)
            $0.top.equalTo(letterView.snp.bottom).offset(10 * heightRatio)
        }
        
        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.leading.equalTo(organizerLabel.snp.trailing).offset(10 * widthRatio)
            $0.top.equalTo(letterView.snp.bottom).offset(10 * heightRatio)
            $0.width.equalTo(1)
            $0.height.equalTo(16 * heightRatio)
        }
        
        view.addSubview(organizerNameLabel)
        organizerNameLabel.snp.makeConstraints {
            $0.top.equalTo(letterView.snp.bottom).offset(8 * heightRatio)
            $0.leading.equalTo(divider.snp.trailing).offset(15.5 * widthRatio)
        }
        
        // 추후 추가
//        tabBarController?.tabBar.isHidden = true
//        view.addSubview(bottomSeparator)
//        bottomSeparator.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(1)
//            $0.bottom.equalTo(-112 * heightRatio)
//        }
//
//        view.addSubview(deleteButton)
//        deleteButton.snp.makeConstraints {
//            $0.top.equalTo(bottomSeparator.snp.bottom).offset(16 * heightRatio)
//            $0.leading.equalTo(20 * widthRatio)
//            $0.trailing.equalTo(-20 * widthRatio)
//            $0.height.equalTo(54 * heightRatio)
//        }
    }
    
    private func requestPlanDetail() { // UI 코드를 분리 시켜야 할듯... 일단 나중에ㅠㅠ
        guard let planID = planID else {
            view.makeToastAnimation(message: "약속 조회 오류! 다시 시도해주세요.")
            return
        }

        CalendarService.shared.getDetailPlanData(planID: planID) { responseData in
            switch responseData {
            case .success(let response):
                guard let response = response as? PlanDetailResponseModel else { return }
                self.eventTitleLabel.text = response.data?.invitationTitle
                self.letterTitleLabel.text = response.data?.invitationTitle
                self.letterContentView.text = response.data?.invitationDesc
                self.organizerNameLabel.text = response.data?.hostName
                (response.data?.possible.map { $0.username } ?? []).forEach {
                    let label = UILabel()
                    label.text = $0
                    label.textColor = UIColor.white
                    label.textAlignment = .center
                    label.backgroundColor = UIColor.pink01
                    label.clipsToBounds = true
                    label.layer.cornerRadius = 13

                    let numberOfCharacters = $0.count
                    label.snp.makeConstraints {
                        $0.height.equalTo(26 * heightRatio)
                        $0.width.equalTo(63 * Int(widthRatio) * numberOfCharacters / 3)
                    }
                    self.nameTagStackView.addArrangedSubview(label)
                    self.nameTagStackView.sizeToFit()
                }
                (response.data?.impossible.map { $0.username } ?? []).forEach {
                    let label = UILabel()
                    label.text = $0
                    label.textColor = UIColor.white
                    label.textAlignment = .center
                    label.backgroundColor = UIColor.grey04
                    label.clipsToBounds = true
                    label.layer.cornerRadius = 13

                    let numberOfCharacters = $0.count
                    label.snp.makeConstraints {
                        $0.height.equalTo(26 * heightRatio)
                        $0.width.equalTo(63 * Int(widthRatio) * numberOfCharacters / 3)
                    }
                    self.nameTagStackView.addArrangedSubview(label)
                    self.nameTagStackView.sizeToFit()
                }
                self.nameTagStackView.snp.remakeConstraints{
                    $0.leading.equalToSuperview().offset(10 * widthRatio)
                    $0.top.equalTo(self.timeLabel.snp.bottom).offset(20 * heightRatio)
                    $0.height.equalTo(46 * heightRatio)
                    $0.width.equalTo(CGFloat(self.nameTagStackView.arrangedSubviews.count) * 73.0 * widthRatio)
                }
                
                let formatter = DateFormatter().then {
                    $0.dateFormat = "yyyy-MM-dd"
                    $0.timeZone =  NSTimeZone(name: "UTC") as TimeZone?
                    $0.locale = Locale(identifier: "ko_KR")
                }
                
                if let responseDate = response.data?.date,
                   let date: Date = formatter.date(from: responseDate){
                    formatter.dateFormat = "yyyy월 M월 d일 E요일"
                    self.navigationTitleLabel.text = formatter.string(from: date)
                }
                
            case .requestErr(let response):
                guard let response = response as? PlanDetailResponseModel,
                      let message = response.message else { return }
                self.view.makeToastAnimation(message: message)
                
            case .pathErr:
                print("Path Err")
                self.view.makeToastAnimation(message: "요청 오류! 다시 시도하십시오.")
                
            case .serverErr:
                print("Server Err")
                self.view.makeToastAnimation(message: "서버 에러! 다시 시도하십시오.")
                
            case .networkFail:
                print("Network Err")
                self.view.makeToastAnimation(message: "통신 오류! 다시 시도하십시오.")
            }
        }
    }
    
    // MARK: - objc
    
    @objc private func touchBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc private func touchDeleteButton(_ sender: UIButton) {
        let nextVC = SMPopUpVC(withType: .deletePlans)
        nextVC.modalPresentationStyle = .overCurrentContext
        present(nextVC, animated: false, completion: nil)
    }

}
