//
//  RequestPlansDateVC.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/16.
//

import UIKit

class RequestPlansDateVC: UIViewController {
    
//MARK: Vars
    var timeList: [String] = ["09 - 11","09 - 14","16 - 21","17 - 23"]
    var planList: [String] = ["마라샹궈","솝트세미나","스터디","데이트"]
    

//MARK: Components
    private let titleView = UIView()
    private let backButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_back"), for: .normal)
    }
    private let titleLabel = UILabel().then{
        $0.text = "약속 신청"
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
    }
    private let closeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_close_bold"), for: .normal)
    }
    private let addDateView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let selectedDateView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let dateLabel = UILabel().then{
        $0.text = "2022.01.04"
        $0.font = UIFont.dinProBoldFont(ofSize:18)
        $0.textColor = UIColor.grey04
    }
    private let timeLabel = UILabel().then{
        $0.text = "오전 11:00 ~ 오전 12:00"
        $0.font = UIFont.dinProRegularFont(ofSize: 14)
        $0.textColor = UIColor.grey04
    }
    private let addButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_embody_on"), for: .normal)
    }
//    private let scrollView = UIScrollView()
    private let scrollView = UIScrollView().then{
        $0.isPagingEnabled = false
       // $0.bounces = true
        $0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = true
       // $0.contentInsetAdjustmentBehavior = .never
       // $0.frame.size = CGSize(width: UIScreen.getDeviceWidth(), height: 700)
    }
    
    private let selectDateLabel = UILabel().then{
        $0.text = "약속 신청할 날짜를 선택하세요"
        $0.font = UIFont.hanSansRegularFont(ofSize: 18)
        $0.textColor = UIColor.grey06
        let attributedString = NSMutableAttributedString(string: "약속 신청할 날짜를 선택하세요")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.pink01, range: ($0.text! as NSString).range(of:"날짜"))
        attributedString.addAttribute(.font, value: UIFont.hanSansBoldFont(ofSize: 18), range: ($0.text! as NSString).range(of: "날짜"))
        $0.attributedText = attributedString
    }
    private let separateLineView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    private let scheduleView = UIView().then{
        $0.backgroundColor = UIColor.grey01
    }
    private let prevWeekButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "leftchevron"), for: .normal)
    }
    private let presentWeekLabel = UILabel().then{
        $0.text = "2022년 2월"
        $0.font = UIFont.dinProMediumFont(ofSize: 18)
        $0.textColor = UIColor.pink01
        $0.textAlignment = .center
    }
    private let nextWeekButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "rightchevron"), for: .normal)
    }
    private let caleandarView = UIView()
    
    private let sunCell = DayCellView().then{
        $0.setDate(montosun: "일", day: 1,isScheduled: false)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let monCell = DayCellView().then{
        $0.setDate(montosun: "월", day: 2,isScheduled: false)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let tueCell = DayCellView().then{
        $0.setDate(montosun: "화", day: 3,isScheduled: true)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let wedCell = DayCellView().then{
        $0.setDate(montosun: "수", day: 4,isScheduled: false)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let thuCell = DayCellView().then{
        $0.setDate(montosun: "목", day: 5,isScheduled: true)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let friCell = DayCellView().then{
        $0.setDate(montosun: "금", day: 6,isScheduled: true)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let satCell = DayCellView().then{
        $0.setDate(montosun: "토", day: 7,isScheduled: false)
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    private let calendarSeparateLineView =  UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    
    private let todayLabel = UILabel().then{
        $0.text = "1월 6일 금요일"
        $0.font = UIFont.hanSansBoldFont(ofSize: 16)
        $0.textColor = UIColor.grey06
    }
    
    private let scheduleTableView = UITableView().then{
        $0.register(ScheduleTVC.self, forCellReuseIdentifier: ScheduleTVC.identifier)
//        $0.backgroundColor = UIColor.grey01
//        $0.backgroundView = nil
       
    }
    
    private let allDayView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let allDayLabel = UILabel().then{
        $0.text = "하루 종일"
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey04
    }
    private let separateLineView2 = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    private let allDaySwitch = UISwitch().then{
        $0.onTintColor = UIColor.pink01
    }
    private let startTimeSettingView = UIView()
    
    private let startTimeLabel = UILabel().then{
        $0.text = "시작 시간"
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey04
    }
    private let startAmPmButton = UIButton().then{
        $0.setTitle("오전", for: .normal)
        $0.setTitleColor(UIColor.grey06, for: .normal)
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.titleLabel?.tintColor = UIColor.grey06
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 18
    }
    private let startDatePicker = UIDatePicker().then{
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent//몰까
        $0.preferredDatePickerStyle = .inline
        
    }

    private let timeSeparateView = UIView().then{
        $0.backgroundColor = UIColor.grey01
    }
    
    
    private let endTimeSettingView = UIView()
    
    private let endTimeLabel = UILabel().then{
        $0.text = "종료 시간"
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey04
    }
    private let endAmPmButton = UIButton().then{
        $0.setTitle("오전", for: .normal)
        $0.setTitleColor(UIColor.grey06, for: .normal)
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.titleLabel?.tintColor = UIColor.grey06
        $0.layer.cornerRadius = 18
        $0.backgroundColor = UIColor.grey01
    }
    private let endDatePicker = UIDatePicker().then{
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent//몰까
        $0.preferredDatePickerStyle = .inline
        
    }
    
    
    
    private let navigationLineView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    
    private let requestPlansButton = UIButton().then{
        $0.backgroundColor = UIColor.pink01
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.layer.cornerRadius = 10
      //  $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    private let fillView = UIView().then{
        $0.backgroundColor = .blue   }


    

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setDelegate()
        

        // Do any additional setup after loading the view.
    }
    
//MARK: Func
    func setDelegate() {
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
    }

//MARK: Layout
    func setLayout() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubviews([titleView,
                          addDateView,
                          scrollView,
                          requestPlansButton])
        
        titleView.addSubviews([backButton,
                               titleLabel,
                               closeButton])
        
        addDateView.addSubviews([selectedDateView,
                                 addButton])
        
        selectedDateView.addSubviews([dateLabel,
                                      timeLabel])
        
        scrollView.addSubviews([selectDateLabel,
                                separateLineView,
                                scheduleView,
                                allDayView,
                                separateLineView2,
                                startTimeSettingView,
                                timeSeparateView,
                                endTimeSettingView,
                                fillView])
        
        scheduleView.addSubviews([prevWeekButton,
                                  presentWeekLabel,
                                  nextWeekButton,
                                  caleandarView,
                                  calendarSeparateLineView,
                                  todayLabel,
                                  scheduleTableView])
        caleandarView.addSubviews([sunCell,monCell,tueCell,wedCell,thuCell,friCell,satCell])
        allDayView.addSubviews([allDayLabel,
                                allDaySwitch])
        startTimeSettingView.addSubviews([startTimeLabel,
                                          startAmPmButton,
                                          startDatePicker])
        endTimeSettingView.addSubviews([endTimeLabel,
                                        endAmPmButton,
                                        endDatePicker])
                                         
                                    
        
        titleView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(58)
        }
        backButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(2)
            $0.width.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        closeButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-4)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        addDateView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(104)
        }
        selectedDateView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(addButton.snp.leading).offset(-8)
            $0.height.equalTo(53)
        }
        dateLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)

        }
        timeLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        addButton.snp.makeConstraints{
            $0.leading.equalTo(selectedDateView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(addDateView.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(-112)
        }

        selectDateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(20)
           // $0.height.equalTo(20)
        }
        separateLineView.snp.makeConstraints{
            $0.top.equalTo(selectDateLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        scheduleView.snp.makeConstraints{
            $0.top.equalTo(separateLineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(330)
        }
        
        prevWeekButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(1)
            $0.width.height.equalTo(42)
        }
        presentWeekLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-18)
            $0.centerY.equalTo(prevWeekButton.snp.centerY)
        }
        nextWeekButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-2)
            $0.centerY.equalTo(presentWeekLabel.snp.centerY)
        }
        caleandarView.snp.makeConstraints{
            $0.top.equalTo(presentWeekLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(90)
        }
        sunCell.snp.makeConstraints{
            $0.trailing.equalTo(monCell.snp.leading).offset(-7)
            $0.centerY.equalTo(wedCell.snp.centerY)
        }
        monCell.snp.makeConstraints{
            $0.trailing.equalTo(tueCell.snp.leading).offset(-7)
            $0.centerY.equalTo(wedCell.snp.centerY)
        }
        tueCell.snp.makeConstraints{
            $0.trailing.equalTo(wedCell.snp.leading).offset(-7)
            $0.centerY.equalTo(wedCell.snp.centerY)
        }
        wedCell.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-2)
            $0.centerX.equalToSuperview()
        }
        thuCell.snp.makeConstraints{
            $0.leading.equalTo(wedCell.snp.trailing).offset(7)
            $0.centerY.equalTo(wedCell.snp.centerY)
        }
        friCell.snp.makeConstraints{
            $0.leading.equalTo(thuCell.snp.trailing).offset(7)
            $0.centerY.equalTo(wedCell.snp.centerY)
        }
        satCell.snp.makeConstraints{
            $0.leading.equalTo(friCell.snp.trailing).offset(7)
            $0.centerY.equalTo(wedCell.snp.centerY)
        }
        calendarSeparateLineView.snp.makeConstraints{
            $0.top.equalTo(caleandarView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        todayLabel.snp.makeConstraints{
            $0.top.equalTo(calendarSeparateLineView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        scheduleTableView.snp.makeConstraints{
            $0.top.equalTo(todayLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        allDayView.snp.makeConstraints{
            $0.top.equalTo(scheduleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(66)
        }
        allDayLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(21)
            $0.centerY.equalToSuperview()
        }
        allDaySwitch.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        separateLineView2.snp.makeConstraints{
            $0.top.equalTo(allDayView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        startTimeSettingView.snp.makeConstraints{
            $0.top.equalTo(separateLineView2.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(63)
        }
        startTimeLabel.snp.makeConstraints{
            $0.leading.equalTo(21)
            $0.centerY.equalToSuperview()
        }
        startAmPmButton.snp.makeConstraints{
            $0.trailing.equalTo(startDatePicker.snp.leading).offset(-12)
            $0.width.equalTo(70)
            $0.height.equalTo(41)
            $0.centerY.equalToSuperview()
        }
        startDatePicker.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-19)
            $0.centerY.equalToSuperview()
        }
        timeSeparateView.snp.makeConstraints{
            $0.top.equalTo(startTimeSettingView.snp.bottom)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(19)
            $0.height.equalTo(1)
        }
        endTimeSettingView.snp.makeConstraints{
            $0.top.equalTo(timeSeparateView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(63)
        }
        endTimeLabel.snp.makeConstraints{
            $0.leading.equalTo(21)
            $0.centerY.equalToSuperview()
        }
        endAmPmButton.snp.makeConstraints{
            $0.trailing.equalTo(startDatePicker.snp.leading).offset(-12)
            $0.width.equalTo(70)
            $0.height.equalTo(41)
            $0.centerY.equalToSuperview()
        }
        endDatePicker.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-19)
            $0.centerY.equalToSuperview()
        }
        fillView.snp.makeConstraints{
            $0.top.equalTo(endTimeSettingView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(77)
            $0.bottom.equalToSuperview()
        }
        
        
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        scheduleTableView.separatorStyle = .none
    }

}


extension RequestPlansDateVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTVC.identifier) as? ScheduleTVC else { return UITableViewCell() }
        cell.setData(time: timeList[indexPath.row], plansTitle: planList[indexPath.row])
        return cell
    }
    
    
}
    
extension RequestPlansDateVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
}

