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
    var timeList: [String] = ["09:30 - 11:00","09:15 - 14:40","16:40 - 21:50","17:35 - 23:20"]
    var planList: [String] = ["마라샹궈","솝트세미나","스터디","데이트"]
    
    var todayDate = Date()
    var selectedDate = PickedDate()//선택된 날짜 + 시간
    var selectedDay = Date()//선택된 날짜
    var addedDateList = [PickedDate]()// 선택된 날짜 + 시간 모음
    var defaultStartDate = Date()
    var defaultEndDate = Date()
    var weekCalendarDateList = [Date]()
    
    var isOpened: Bool = false
    
    
    private var scheduleData: [ScheduleData]? {
        didSet {
//            if initialFlag {
//                displayPlansCollectionView()
//                initialFlag.toggle()
//            }
        }
    }
    

//MARK: Components
    var cellList = [DayCellView]()
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
        $0.bounces = false

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
        $0.backgroundColor = UIColor.pink01
        $0.setTitle("약속 신청", for: .normal)
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.layer.cornerRadius = 10
      //  $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    private let fillView = UIView().then{
        $0.backgroundColor = .white   }
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setDelegate()
        initSelectedDay()
        setCellList()
        initSelectedTime()
        setTarget()
        initWeekCalendarDataList()
        layoutCalendarView()
        
        // Do any additional setup after loading the view.
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
    

    func initWeekCalendarDataList() {
    
        switch Date.getKoreanWeekDay(from: todayDate){
        case "일":
            let num = WeekDay.Sun.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
        case "월":
            let num = WeekDay.Mon.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
            
        case "화":
            let num = WeekDay.Tue.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
        case "수":
            let num = WeekDay.Wed.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
        case "목":
            let num = WeekDay.Thu.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
        case "금":
            let num = WeekDay.Fri.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
        case "토":
            let num = WeekDay.Sat.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
        default:
            let num = WeekDay.Sun.rawValue
            for x in 0...(6-num-1){
                weekCalendarDateList.append(todayDate.previousDate(value: 6-num-x))
            }
            weekCalendarDateList.append(todayDate)
            for x in 0...(num-1){
                weekCalendarDateList.append(todayDate.nextDate(value: x+1))
            }
            
        }

    }
    
    func layoutCalendarView(){
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
            
            cellList[i].setDate(montosun: montosun, day: day, isScheduled: true)
            if(weekCalendarDateList[i].compare(todayDate) == .orderedAscending){
                cellList[i].setInvalidStae()
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
        }
        if hasToday == true{
            prevWeekButton.isHidden = true
        }else{
            prevWeekButton.isHidden = false
        }
        setPresentWeekLabel()
        
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
            
        
//
//            guard let hourRevisedStartDate = Calendar.current.date(bySetting: .hour, value: 0, of: selectedDate.startTime)else {return}
//
//            guard let minuteRevisedStartDate = Calendar.current.date(bySetting: .minute, value: 0, of: hourRevisedStartDate) else {return}

        
//            guard let hourRevisedEndDate = Calendar.current.date(bySetting: .hour, value: 23, of: selectedDate.endTime)else {return}
//
//            guard let minuteRevisedEndDate = Calendar.current.date(bySetting: .minute, value: 55, of: hourRevisedEndDate ) else {return}
            
//
//            selectedDate.startTime = startDate
//            selectedDate.endTime = endDate
            
            
            
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
        
            
//            guard let hourRevisedStartDate = Calendar.current.date(bySetting: .hour, value: 9, of: selectedDate.startTime)else {return}
//
//            guard let minuteRevisedStartDate = Calendar.current.date(bySetting: .minute, value: 0, of: hourRevisedStartDate) else {return}
//
//            guard let hourRevisedEndDate = Calendar.current.date(bySetting: .hour, value: 14, of: selectedDate.endTime)else {return}
//
//            guard let minuteRevisedEndDate = Calendar.current.date(bySetting: .minute, value: 0, of: hourRevisedEndDate ) else {return}
//
//            selectedDate.startTime = minuteRevisedStartDate
//            selectedDate.endTime = minuteRevisedEndDate
           
     
         
        }
        
    }
    @objc func tapNextButton(){
        
        for i in 0..<weekCalendarDateList.count{
            weekCalendarDateList[i] = weekCalendarDateList[i].nextWeekDate()

        }
        
        layoutCalendarView()
        
       }
    @objc func tapPreviousButton(){
        
        for i in 0..<weekCalendarDateList.count{
            weekCalendarDateList[i] = weekCalendarDateList[i].prevWeekDate()
        }
        layoutCalendarView()
        
       }
    
    @objc func tapAddButton(){
        bottomSheetView.addPickedDate(date: selectedDate)
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
        
        emptyScheduleLabel.isHidden = true
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

extension RequestPlansDateVC: TapTouchAreaViewDelegate{
    func tapTouchAreaView(dateSheetView: SelectedDateSheet) {
        
        switch isOpened{
        case false :
            isOpened = true
            bottomSheetView.snp.updateConstraints {
                $0.bottom.equalTo(navigationBarView.snp.bottom).offset(310)
             }
    
        case true:
            bottomSheetView.snp.updateConstraints {
                $0.bottom.equalTo(navigationBarView.snp.bottom)
             }
            isOpened = false
      
        }
        
        
    }
    
   
}

extension RequestPlansDateVC: tapCellViewDelegate{
    func tapCellView(dayCellView: DayCellView) {
      
        switch dayCellView.montosun{
        case "일":
            selectedDay = weekCalendarDateList[0]
            
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[0].year, month: weekCalendarDateList[0].month, day: weekCalendarDateList[0].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[0].year, month: weekCalendarDateList[0].month, day: weekCalendarDateList[0].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            

            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
           
        case "월":
            selectedDay = weekCalendarDateList[1]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[1].year, month: weekCalendarDateList[1].month, day: weekCalendarDateList[1].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[1].year, month: weekCalendarDateList[1].month, day: weekCalendarDateList[1].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
        case "화":
            selectedDay = weekCalendarDateList[2]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[2].year, month: weekCalendarDateList[2].month, day: weekCalendarDateList[2].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[2].year, month: weekCalendarDateList[2].month, day: weekCalendarDateList[2].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
        case "수":
            selectedDay = weekCalendarDateList[3]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[3].year, month: weekCalendarDateList[3].month, day: weekCalendarDateList[3].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[3].year, month: weekCalendarDateList[3].month, day: weekCalendarDateList[3].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
        case "목":
            selectedDay = weekCalendarDateList[4]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[4].year, month: weekCalendarDateList[4].month, day: weekCalendarDateList[4].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[4].year, month: weekCalendarDateList[4].month, day: weekCalendarDateList[4].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
        case "금":
            selectedDay = weekCalendarDateList[5]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[5].year, month: weekCalendarDateList[5].month, day: weekCalendarDateList[5].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[5].year, month: weekCalendarDateList[5].month, day: weekCalendarDateList[5].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
        case "토":
            selectedDay = weekCalendarDateList[6]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[6].year, month: weekCalendarDateList[6].month, day: weekCalendarDateList[6].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[6].year, month: weekCalendarDateList[6].month, day: weekCalendarDateList[6].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
        default:
            selectedDay = weekCalendarDateList[0]
            //선택한 요일 셀의 날짜들을 가져와서 상단의 선택된 날짜 데이터를 갱신. 시간과 분은 유지
            let revisedStartDateComponents = DateComponents(year: weekCalendarDateList[0].year, month: weekCalendarDateList[0].month, day: weekCalendarDateList[0].day, hour: selectedDate.startTime.hour ,minute: selectedDate.startTime.minute)
            
            guard let revisedStartDate = Calendar.current.date(from: revisedStartDateComponents) else{return}
            selectedDate.startTime = revisedStartDate
            
            let revisedEndDateComponents = DateComponents(year: weekCalendarDateList[0].year, month: weekCalendarDateList[0].month, day: weekCalendarDateList[0].day, hour: selectedDate.endTime.hour ,minute: selectedDate.endTime.minute)
            
            guard let revisedEndDate = Calendar.current.date(from: revisedEndDateComponents) else{return}
            
            selectedDate.endTime = revisedEndDate
            updateSelectedDateLabel()
            
           
        }
       
        layoutCalendarView()
        
    }
    
    
}

//MARK: Network

extension RequestPlansDateVC{
    func requestPlans(){
        PostRequestPlansService.shared.requestPlans(guest: <#T##[Host]#>, title: <#T##String#>, contents: <#T##String#>, date: <#T##[String]#>, start: <#T##[String]#>, end: <#T##[String]#>){ responseData in
            switch responseData {
            case.success(let requestResponse):
                guard let response = requestResponse as? RequestResponseData else { return }
                if let plansData = response.data{
                    //노티피케이션 센터 이용해서 팝시키고 메인에 토스트 띄우기
                }
            case .requestErr(let msg):
                print("requestERR \(msg)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            
            }
        }
    }
    
    func requestCalendarData(year: String, month: String) {
        GetScheduleService.shared.getScheduleData(year: <#T##String#>, month: <#T##String#>)  { responseData in
            switch responseData {
            case .success(let response):
                guard let response = response as? InvitationPlanData else { return }
                self.scheduleData = response.data
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

