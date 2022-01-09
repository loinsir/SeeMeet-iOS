import UIKit
import Then
import SnapKit
import FSCalendar

class CalendarVC: UIViewController {
    
    // MARK: - properties
    
    static let identifier: String = "CalendarVC"
    
    let calendarHeaderLabel: UILabel = UILabel().then {
        $0.textColor = UIColor.pink01
        $0.font = UIFont(name: "DINPro-Bold", size: 22)
    }
    
    let calendar: FSCalendar = FSCalendar().then {
        $0.select($0.today)
        $0.scope = .month
        $0.locale = Locale(identifier: "ko_KR")
        $0.scrollDirection = .horizontal
        $0.allowsMultipleSelection = false
        $0.calendarHeaderView.isHidden = true
        $0.weekdayHeight = CGFloat(55.0)
        
        $0.headerHeight = CGFloat.zero
        $0.appearance.titleFont =  UIFont(name: "DINPro-Regular", size: 16.0)
        $0.appearance.weekdayTextColor = UIColor.grey05
        $0.appearance.titleDefaultColor = UIColor.grey05 // grey06으로 추후 변경
        $0.appearance.todayColor = UIColor.pink01
        $0.appearance.eventDefaultColor = UIColor.pink01
        $0.appearance.selectionColor = UIColor.grey05 // grey06으로 추후 변경
    }
    
    let bottomCollectionContainerView: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey01
    }
    
    let dateAndDayLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        $0.textColor = UIColor.grey05 // grey06 추후 변경
        
        let nowDate = Date()
        let currentMonth = Calendar.current.component(.month, from: nowDate)
        let currentDate = Calendar.current.component(.day, from: nowDate)
        $0.text = "\(currentMonth)월 \(currentDate)일 \(Date.getCurrentKoreanWeekDay())요일"
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayouts()
    }
    
    // MARK: - layout
    
    private func setLayouts() {
        navigationController?.navigationBar.isHidden = true
        
        addSubviewAndConstraints(add: calendarHeaderLabel, to: view) {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        // 화면 작은 애들은 추후 수정 필요...?
        calendar.delegate = self
        addSubviewAndConstraints(add: calendar, to: view) {
            $0.top.equalTo(calendarHeaderLabel.snp.bottom).offset(9)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(378)
            $0.height.equalTo(418)
        }
        
        addSubviewAndConstraints(add: bottomCollectionContainerView, to: view) {
            $0.top.equalTo(calendar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            if UIScreen.hasNotch {
                $0.bottom.equalTo(view.snp.bottom).offset(87)
            } else {
                $0.bottom.equalTo(view.snp.bottom).offset(77)
            }
        }
        
        addSubviewAndConstraints(add: dateAndDayLabel, to: bottomCollectionContainerView) {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(16)
        }
    }
    
    private func addSubviewAndConstraints(add subView: UIView, to superView: UIView, snapkitClosure closure: (ConstraintMaker) -> Void) {
        superView.addSubview(subView)
        subView.snp.makeConstraints(closure)
    }

}

// MARK: - Extension

extension CalendarVC: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let currentPage = calendar.currentPage
        let currentYear = Calendar.current.component(.year, from: currentPage)
        let currentMonth = Calendar.current.component(.month, from: currentPage)
        
        calendarHeaderLabel.text = "\(currentYear)년 \(currentMonth)월"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedMonth = Calendar.current.component(.month, from: date)
        let selectedDate = Calendar.current.component(.day, from: date)

        dateAndDayLabel.text = "\(selectedMonth)월 \(selectedDate)일 \(Date.getKoreanWeekDay(from: date))요일"
    }
}
