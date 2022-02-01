//
//  RequestPlansDateVC.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/16.
//

import UIKit

fileprivate let heightRatio = UIScreen.getDeviceHeight() / 812


class RequestPlansDateVC: UIViewController {
    
//MARK: Vars
    var planList: [(String, String)] = [] // (timeString, planTitle)
    
    var planDict: [String: String] = [:]
    
    var todayDate = Date()
    var selectedDate = PickedDate()//선택된 날짜 + 시간
    var selectedDay = Date()//선택된 날짜
    // 선택된 날짜 + 시간 모음
    var addedDateList = [PickedDate]()//안 쓰임
    var defaultStartDate = Date()
    var defaultEndDate = Date()
    var weekCalendarDateList = [Date]()//일곱개 날짜 배열
    
    var isOpened: Bool = false
    
    // 넘겨받은 데이터
    var guestsToRequest: [[String: Any]] = []
    var titleToRequest: String = ""
    var contentsToRequest: String = ""
    
    
    private var scheduleDataList: [ScheduleData]?
    

//MARK: Components
    var cellList = [DayCellView]()
    private let titleView = UIView()
    private let backButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_back"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    }
    private let titleLabel = UILabel().then{
        $0.text = "약속 신청"
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
    }
    private let addDateView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let selectedDateView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.pink01.cgColor
        $0.layer.borderWidth = 1
    }
    private let dateLabel = UILabel().then{
        $0.text = "2022.01.04"
        $0.font = UIFont.dinProBoldFont(ofSize:18)
        $0.textColor = UIColor.grey06
    }
    private let timeLabel = UILabel().then{
        $0.text = "오전 11:00 ~ 오전 12:00"
        $0.font = UIFont.dinProRegularFont(ofSize: 14)
        $0.textColor = UIColor.grey06
    }
    private let addButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_embody_on"), for: .normal)
    }
//    private let scrollView = UIScrollView()
    private let scrollView = UIScrollView().then{
        $0.isPagingEnabled = false
        $0.bounces = true
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
        $0.tag = 1
    }
    private let presentWeekLabel = UILabel().then{
        $0.text = "2022년 2월"
        $0.font = UIFont.dinProMediumFont(ofSize: 18)
        $0.textColor = UIColor.pink01
        $0.textAlignment = .center
    }
    private let nextWeekButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "rightchevron"), for: .normal)
        $0.tag = 2
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
    
    private let scheduleTableView = UITableView(frame: CGRect.zero, style: .plain).then{
        $0.register(ScheduleTVC.self, forCellReuseIdentifier: ScheduleTVC.identifier)
        $0.bounces = false
        $0.backgroundColor = UIColor.grey04
    }
    private let emptyScheduleLabel = UILabel().then{
        $0.text = "일정이 없어요"
        $0.font = UIFont.hanSansRegularFont(ofSize: 16)
        $0.textColor = UIColor.grey04
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
//    private let startAmPmButton = UIButton().then{
//        $0.setTitle("오전", for: .normal)
//        $0.setTitleColor(UIColor.grey06, for: .normal)
//        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
//        $0.titleLabel?.tintColor = UIColor.grey06
//        $0.backgroundColor = UIColor.grey01
//        $0.layer.cornerRadius = 18
//    }
    private let startDatePicker = UIDatePicker().then{
            $0.datePickerMode = .time
            $0.locale = Locale(identifier: "ko-KR")
            $0.timeZone = .autoupdatingCurrent//몰까
            $0.preferredDatePickerStyle = .inline
            $0.minuteInterval = 5
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
//    private let endAmPmButton = UIButton().then{
//        $0.setTitle("오전", for: .normal)
//        $0.setTitleColor(UIColor.grey06, for: .normal)
//        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 14)
//        $0.titleLabel?.tintColor = UIColor.grey06
//        $0.layer.cornerRadius = 18
//        $0.backgroundColor = UIColor.grey01
//    }
    private let endDatePicker = UIDatePicker().then{
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent//몰까
        $0.preferredDatePickerStyle = .inline
        $0.minuteInterval = 5
       
        
    }
    private let bottomSheetView = SelectedDateSheet()
    
    
    private let navigationLineView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    private let navigationBarView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    
    private let requestPlansButton = UIButton().then{
        $0.backgroundColor = UIColor.grey02
        $0.setTitle("약속 신청", for: .normal)
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.layer.cornerRadius = 10
        $0.isUserInteractionEnabled = false
        $0.addTarget(self, action: #selector(touchRequestButton(_:)), for: .touchUpInside)
    }
    private let fillView = UIView().then{
        $0.backgroundColor = .white   }
    
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setDelegate()
        initSelectedDay()
        setCellList()
        initSelectedTime()
        setTarget()
        initWeekCalendarDataList()
        initScheduleDataList()
        layoutCalendarView()
        initDayLabel()

        
        // Do any additional setup after loading the view.
    }
    @objc func touchRequestButton(_ button: UIButton) {
        let planDateList = bottomSheetView.pickedDateList
        
        let date = planDateList.map { $0.getDateStringForRequest() }
        let start = planDateList.map { $0.getStartTimeStringForRequest()}
        let end = planDateList.map {  $0.getEndTimeStringForRequest() }
        
        requestPlans(guests: guestsToRequest, title: titleToRequest, contents: contentsToRequest, date: date, start: start, end: end)
    }
    
   
        
    
   
    
//MARK: Func
    func initSelectedDay(){
        selectedDay = todayDate
    }
    func setDelegate() {
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        bottomSheetView.tapTouchAreaViewDelegate = self
        sunCell.tapCellViewDelegate = self
        monCell.tapCellViewDelegate = self
        tueCell.tapCellViewDelegate = self
        wedCell.tapCellViewDelegate = self
        thuCell.tapCellViewDelegate = self
        friCell.tapCellViewDelegate = self
        satCell.tapCellViewDelegate = self
        bottomSheetView.pickedDateListDelegate = self
        
    }
    func setCellList() {
        cellList.append(contentsOf:[sunCell,monCell,tueCell,wedCell,thuCell,friCell,satCell])
    }
    func setTarget() {
        allDaySwitch.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
        startDatePicker.addTarget(self, action: #selector(changedStartDatePicker), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(changedEndDatePicker), for: .valueChanged)
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        
        nextWeekButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        prevWeekButton.addTarget(self, action: #selector(tapPreviousButton), for: .touchUpInside)
        
        
       

    
    }

    func initDayLabel(){
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        let dateText = formatter.string(from: todayDate) + " \(Date.getKoreanWeekDay(from: todayDate))요일"
       
        todayLabel.text  = dateText
    }
    func initSelectedTime(){
       
        let min = Calendar.current.component(.minute, from: todayDate)
        
        selectedDate.startTime = todayDate// 상단 선택된 시간 라벨의 초기값은 오늘 날짜이고 시간은 아래 기준으로 결정
        
        //시간이 30분 이하일 때 다음 정각으로 설정
        if Int(min)<30{

            guard let minuteRevisedDate = Calendar.current.date(bySetting: .minute, value: 0, of: selectedDate.startTime) else {return}
            selectedDate.startTime = minuteRevisedDate//올림해줘버림..
            
            guard let hourRevisedDate = Calendar.current.date(byAdding: .hour, value: 1, to: selectedDate.endTime) else {return}
            selectedDate.endTime = hourRevisedDate
            
            guard let minuteRevisedDate = Calendar.current.date(bySetting: .minute, value: 0, of: selectedDate.endTime) else {return}
            selectedDate.endTime = minuteRevisedDate
            updateSelectedDateLabel()
            

        }else{//30분 이상일 때 다음 삼십분으로 설정
//            guard let hourRevisedDate = Calendar.current.date(byAdding: .hour, value: 1, to: selectedDate.startTime) else {return}
//            selectedDate.startTime = hourRevisedDate
//
            guard let minuteRevisedDate = Calendar.current.date(bySetting: .minute, value: 30, of: selectedDate.startTime) else {return}
            selectedDate.startTime = minuteRevisedDate
            
            guard let hourRevisedDate = Calendar.current.date(byAdding: .hour, value: 1, to: selectedDate.endTime) else {return}
            selectedDate.endTime = hourRevisedDate
            
            guard let minuteRevisedDate = Calendar.current.date(bySetting: .minute, value: 30, of: selectedDate.endTime) else {return}
            selectedDate.endTime = minuteRevisedDate
        }
        updateSelectedDateLabel()
        

        }
        
    func updateSelectedDateLabel() {
            dateLabel.text = selectedDate.getDateString()
            timeLabel.text = selectedDate.getStartToEndString()
           
        }
    func initScheduleDataList(){
        let year = String(todayDate.year)
        let month = String(todayDate.month)
        
        requestCalendarData(year: year, month: month)
    }
    
    func appendWeekCalendarDateList(num: Int) {
        for x in 0...6 {
            if x < num {
                weekCalendarDateList.append(todayDate.previousDate(value: num-x))
            } else if x == num {
                weekCalendarDateList.append(todayDate)
            } else {
                weekCalendarDateList.append(todayDate.nextDate(value: x-num))
            }
        }
    }
    

    func initWeekCalendarDataList() {
    
        switch Date.getKoreanWeekDay(from: todayDate){
        case "일":
            appendWeekCalendarDateList(num: 0)
        case "월":
            appendWeekCalendarDateList(num: 1)
        case "화":
            appendWeekCalendarDateList(num: 2)
        case "수":
            appendWeekCalendarDateList(num: 3)
        case "목":
            appendWeekCalendarDateList(num: 4)
        case "금":
            appendWeekCalendarDateList(num: 5)
        case "토":
            appendWeekCalendarDateList(num: 6)
        default:
            break
        }

    }
    
    func layoutCalendarView(_ tag: Int? = 0){
     var hasToday: Bool = false
        for i in 0..<cellList.count{
            
            let day = weekCalendarDateList[i].day//캘린더 데이터의 데이
            var montosun  = String()//캘린더 요일 라벨 설정
            switch i{
            case 0 : montosun = "일"
            case 1 : montosun = "월"
            case 2 : montosun = "화"
            case 3 : montosun = "수"
            case 4 : montosun = "목"
            case 5 : montosun = "금"
            case 6 : montosun = "토"
            default:montosun = "토"
            }
            cellList[i].cellView.isUserInteractionEnabled = true
            
            //요일셀 날짜 설정
            cellList[i].setDate(montosun: montosun, day: day, isScheduled: true)
            //요일셀 상태 설정
            if(weekCalendarDateList[i].compare(todayDate) == .orderedAscending){
                cellList[i].setInvalidState()
                cellList[i].cellView.isUserInteractionEnabled = false
            }
            else if((weekCalendarDateList[i].compare(todayDate) == .orderedSame) && (weekCalendarDateList[i].compare(selectedDay) == .orderedSame)){
                cellList[i].setTodaySelectedState()
                hasToday = true
            }
            else if((weekCalendarDateList[i].compare(todayDate) ==  .orderedSame) && (weekCalendarDateList[i].compare(selectedDay) != .orderedSame)){
                cellList[i].setTodayState()
               hasToday = true
            }else if((weekCalendarDateList[i].compare(todayDate) !=  .orderedSame) && (weekCalendarDateList[i].compare(selectedDay) == .orderedSame)){
                cellList[i].setSelectedState()
            }
            else{
                cellList[i].setBasicState()
            }
            
            displayRedDot()

        }
        if hasToday == true{
            prevWeekButton.isHidden = true
        }else{
            prevWeekButton.isHidden = false
        }
        
        if (weekCalendarDateList.first?.year != weekCalendarDateList.last?.year) || (weekCalendarDateList.first?.month != weekCalendarDateList.last?.month){
            guard let firstYear = weekCalendarDateList.first?.year else {return}
            guard let  firstMonth = weekCalendarDateList.first?.month else {return}
            guard let  lastYear = weekCalendarDateList.last?.year else {return}
            guard let  lastMonth = weekCalendarDateList.last?.month else {return}
            switch tag{
            case 1:
            requestCalendarData(year: String(firstYear), month: String(firstMonth))
            case 2:
                requestCalendarData(year: String(lastYear), month: String(lastMonth))
            default:
                break
            }
            
            
            
        }
        setPresentWeekLabel()
        
    }
    private func displayRedDot() {
        //요일셀 빨간불 설정
        for (index, date) in weekCalendarDateList.enumerated() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
            cellList[index].isScheduled = false
            
            let dateString: String = formatter.string(from: date)
            
            scheduleDataList?.forEach {
                if dateString == $0.date {
                    cellList[index].isScheduled = true
                }
            }
        }
    }
    
    func setPresentWeekLabel(){
        if (weekCalendarDateList.first?.year != weekCalendarDateList.last?.year) || (weekCalendarDateList.first?.month != weekCalendarDateList.last?.month){
            
            
            guard let firstYear = weekCalendarDateList.first?.year else {return}
            guard let  firstMonth = weekCalendarDateList.first?.month else {return}
            guard let  lastYear = weekCalendarDateList.last?.year else {return}
            guard let  lastMonth = weekCalendarDateList.last?.month else {return}
            presentWeekLabel.text = "\(firstYear)년 \(firstMonth)월-\(lastYear)년 \(lastMonth)월"
        
            
        }else {
            guard let   year = weekCalendarDateList.first?.year else {return}
            guard let  month = weekCalendarDateList.first?.month else {return}
           
          
            presentWeekLabel.text = "\(year)년 \(month)월"
        }
    }
//
    @objc func changedStartDatePicker(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
       // let date = dateformatter.string(from: startDatePicker.date)
        let startDateComponents = DateComponents(year: selectedDate.startTime.year, month: selectedDate.startTime.month, day: selectedDate.startTime.day, hour: startDatePicker.date.hour ,minute: startDatePicker.date.minute)
        
        guard let revisedStartDate = Calendar.current.date(from: startDateComponents) else{return}
        

        selectedDate.startTime = revisedStartDate
        updateSelectedDateLabel()
      
    }
    @objc func changedEndDatePicker(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        
        let endDateComponents = DateComponents(year: selectedDate.startTime.year, month: selectedDate.startTime.month, day: selectedDate.startTime.day, hour: endDatePicker.date.hour,minute:  endDatePicker.date.minute)
        
        guard let revisedEndDate = Calendar.current.date(from: endDateComponents) else{return}

        selectedDate.endTime = revisedEndDate
        updateSelectedDateLabel()
        
        
       
    }
    @objc func onClickSwitch(sender: UISwitch) {
        if sender.isOn {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "a hh:mm"
            dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
            dateFormatter.locale = Locale(identifier: "ko_KR")
            guard let startDate = dateFormatter.date(from: "오전 12:00") else{ return}
            startDatePicker.setDate(startDate,animated: true)
            guard let endDate = dateFormatter.date(from: "오후 11:55") else{ return}
            endDatePicker.setDate(endDate,animated: true)

            
            let startDateComponents = DateComponents(year: selectedDate.startTime.year, month: selectedDate.startTime.month, day: selectedDate.startTime.day, hour: 0,minute: 0)
            
            guard let revisedStartDate = Calendar.current.date(from: startDateComponents) else{return}
            
   
            
            let endDateComponents = DateComponents(year: selectedDate.startTime.year, month: selectedDate.startTime.month, day: selectedDate.startTime.day, hour:23,minute: 55)
            
            guard let revisedEndDate = Calendar.current.date(from: endDateComponents) else{return}

            selectedDate.startTime = revisedStartDate
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
            
            
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "a hh:mm"
            dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
            dateFormatter.locale = Locale(identifier: "ko_KR")
            guard let startDate = dateFormatter.date(from: "오전 09:00") else{ return}
            startDatePicker.setDate(startDate,animated: true)
            guard let endDate = dateFormatter.date(from: "오후 02:00") else{ return}
            endDatePicker.setDate(endDate,animated: true)
  
            let startDateComponents = DateComponents(year: selectedDate.startTime.year, month: selectedDate.startTime.month, day: selectedDate.startTime.day, hour: 9,minute: 0)
            
            guard let revisedStartDate = Calendar.current.date(from: startDateComponents) else{return}
            
            let endDateComponents = DateComponents(year: selectedDate.startTime.year, month: selectedDate.startTime.month, day: selectedDate.startTime.day, hour:14,minute: 0)
            
            guard let revisedEndDate = Calendar.current.date(from: endDateComponents) else{return}

            selectedDate.startTime = revisedStartDate
            selectedDate.endTime = revisedEndDate
        
            updateSelectedDateLabel()
        
         
        }
        
    }
    @objc func tapNextButton(_ sender: UIButton){
        
        for i in 0..<weekCalendarDateList.count{
            weekCalendarDateList[i] = weekCalendarDateList[i].nextWeekDate()

        }
        
        layoutCalendarView(sender.tag)
        
       }
    @objc func tapPreviousButton(_ sender: UIButton){
        
        for i in 0..<weekCalendarDateList.count{
            weekCalendarDateList[i] = weekCalendarDateList[i].prevWeekDate()
        }
        layoutCalendarView(sender.tag)
        
       }
    
    @objc func tapAddButton(){
        bottomSheetView.addPickedDate(date: selectedDate)
    }
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
    

    

//MARK: Layout
    func setLayout() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubviews([titleView,
                          addDateView,
                          scrollView,
                          bottomSheetView,
                          navigationLineView,
                          navigationBarView
                          ])
        
        titleView.addSubviews([backButton,
                               titleLabel])
        
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
                                  scheduleTableView,
                                  emptyScheduleLabel])
        caleandarView.addSubviews([sunCell,monCell,tueCell,wedCell,thuCell,friCell,satCell])
        allDayView.addSubviews([allDayLabel,
                                allDaySwitch])
        startTimeSettingView.addSubviews([startTimeLabel,
                                          //startAmPmButton,
                                          startDatePicker])
        endTimeSettingView.addSubviews([endTimeLabel,
                                       // endAmPmButton,
                                        endDatePicker])
        
        navigationBarView.addSubview(requestPlansButton)
                                         
                                    
        
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
        emptyScheduleLabel.snp.makeConstraints{
            $0.top.equalTo(calendarSeparateLineView.snp.bottom).offset(88)
            $0.centerX.equalToSuperview()
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
//        startAmPmButton.snp.makeConstraints{
//            $0.trailing.equalTo(startDatePicker.snp.leading).offset(-12)
//            $0.width.equalTo(70)
//            $0.height.equalTo(41)
//            $0.centerY.equalToSuperview()
//        }
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
//        endAmPmButton.snp.makeConstraints{
//            $0.trailing.equalTo(startDatePicker.snp.leading).offset(-12)
//            $0.width.equalTo(70)
//            $0.height.equalTo(41)
//            $0.centerY.equalToSuperview()
//        }
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
        bottomSheetView.snp.makeConstraints{
            $0.bottom.equalTo(navigationBarView.snp.bottom).offset(310)
            $0.trailing.leading.equalToSuperview().offset(0)
            $0.height.equalTo(480)
        }
        navigationLineView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(requestPlansButton.snp.top).offset(-16)
            $0.height.equalTo(1)
        }
        navigationBarView.snp.makeConstraints{
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(112)
        }
        requestPlansButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-42)
            $0.height.equalTo(54)
        }
        
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        scheduleTableView.separatorStyle = .none
        scheduleTableView.backgroundColor = UIColor.grey01
        
        emptyScheduleLabel.isHidden = true
    }

}


extension RequestPlansDateVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if planList.count == 0 {
            scheduleTableView.isHidden = true
            emptyScheduleLabel.isHidden = false
        } else {
            scheduleTableView.isHidden = false
            emptyScheduleLabel.isHidden = true
        }
        
        return planList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTVC.identifier) as? ScheduleTVC else { return UITableViewCell() }
        cell.setData(time: planList[indexPath.row].0, plansTitle: planList[indexPath.row].1)
        return cell
    }
    
    
}
    
extension RequestPlansDateVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
}

extension RequestPlansDateVC: TapTouchAreaViewDelegate{
    func tapTouchAreaView(dateSheetView: SelectedDateSheet) {
        
        switch isOpened{
        case false :
            isOpened = true
            UIView.animate(withDuration: 1.0){
                let yFrame = CGAffineTransform(translationX: 0, y: -310)
                self.bottomSheetView.transform = yFrame
            }
//            bottomSheetView.snp.updateConstraints {
//                $0.bottom.equalTo(navigationBarView.snp.bottom).offset(310)
//             }
    
        case true:
//            bottomSheetView.snp.updateConstraints {
//                $0.bottom.equalTo(navigationBarView.snp.bottom)
//             }
            UIView.animate(withDuration: 1.0){
                let yFrame = CGAffineTransform(translationX: 0, y: 0)
                self.bottomSheetView.transform = yFrame
            }
            isOpened = false
        }
    }
}


extension RequestPlansDateVC: tapCellViewDelegate{
    func tapCellView(dayCellView: DayCellView) {
        planList.removeAll()
      
        switch dayCellView.montosun{
        case "일":
            setSelectedDayLabel(by: 0)
            setScheduleTableDataList(by: 0)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[0], week: "일")
                                                    
        case "월":
            setSelectedDayLabel(by: 1)
            setScheduleTableDataList(by: 1)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[1], week: "월")
            
        case "화":
            setSelectedDayLabel(by: 2)
            setScheduleTableDataList(by: 2)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[2], week: "화")
            
        case "수":
            setSelectedDayLabel(by: 3)
            setScheduleTableDataList(by: 3)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[3], week: "수")
            
        case "목":
            setSelectedDayLabel(by: 4)
            setScheduleTableDataList(by: 4)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[4], week: "목")
            
        case "금":
            setSelectedDayLabel(by: 5)
            setScheduleTableDataList(by: 5)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[5], week: "금")
            
        case "토":
            setSelectedDayLabel(by: 6)
            setScheduleTableDataList(by: 6)
            todayLabel.text = makeTodayLabelText(from: weekCalendarDateList[6], week: "토")
            
        default:
            break
        }
        layoutCalendarView()
       
        scheduleTableView.reloadData()
        
    }
    
    private func makeTodayLabelText(from: Date, week: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        let dateText = formatter.string(from: from) + " \(week)요일"
        return dateText
    }
    
    private func setScheduleTableDataList(by weekDay: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        let dateString: String = formatter.string(from: weekCalendarDateList[weekDay])
        
        scheduleDataList?.sort { $0 < $1 }
        
        scheduleDataList?.forEach {
            if dateString == $0.date {
                let key = "\($0.start) - \($0.end)"
                planList.append((key, $0.invitationTitle))
            }
        }
        
        
    }
    
    private func setSelectedDayLabel(by weekday: Int) {
        selectedDay = weekCalendarDateList[weekday]
        //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
        let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[weekday].year, month: weekCalendarDateList[weekday].month, day: weekCalendarDateList[weekday].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
        
        guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
        selectedDate.startTime = revisedStartDate
        
        let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[weekday].year, month: weekCalendarDateList[weekday].month, day: weekCalendarDateList[weekday].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
        
        guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
        
        selectedDate.endTime = revisedEndDate
        updateSelectedDateLabel()
    }
    
    
}

extension RequestPlansDateVC: PickedDateListChangedDelegate{
    func pickedDateListChanged(view: SelectedDateSheet) {
        if view.pickedDateList.count > 0 {
            requestPlansButton.backgroundColor = UIColor.pink01
            requestPlansButton.isUserInteractionEnabled  = true
        }else{
            requestPlansButton.backgroundColor = UIColor.grey02
            requestPlansButton.isUserInteractionEnabled  = false
        }
    }
}

//MARK: Network

extension RequestPlansDateVC{
    
    private func requestPlans(guests: [[String: Any]],
                              title: String,
                              contents: String,
                              date: [String],
                              start: [String],
                              end: [String]
                              ) {
        print(guests, title, contents, date, start, end, "gdadfsa")
        PostRequestPlansService.shared.requestPlans(
            guests: guests,
            title: title,
            contents: contents,
            date: date,
            start: start,
            end: end) { responseData in
                switch responseData {
                case .success(_), .pathErr:
                    let nextStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                    let nextVC = nextStoryboard.instantiateViewController(identifier: "TabbarVC")
                    self.tabBarController?.tabBar.isHidden = false
                    self.tabBarController?.selectedIndex = 0
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toastMessage"), object: "약속 신청을 완료했어요.")
                case .requestErr(_):
                    print("request err")
                case .networkFail:
                    print("network err")
                case .serverErr:
                    print("server err")
                }
            }
    }
    

    func requestCalendarData(year: String, month: String) {
        GetScheduleService.shared.getScheduleData(year: year, month: month)  { responseData in
            switch responseData {
            case .success(let response):
                guard let response = response as? InvitationPlanData else { return }
                
                
                self.scheduleDataList = response.data
                self.layoutCalendarView()
                
            
                
               // self.calendar.reloadData()
            case .requestErr(let msg):
                print(msg)
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network Fail")
            }
        }
    }

}
