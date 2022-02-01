import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812
//fileprivate let heightRatio = 1.0
fileprivate let widthRatio = userWidth / 375
//fileprivate let widthRatio = 1.0

protocol TapTouchAreaViewDelegate{
    func tapTouchAreaView(dateSheetView: SelectedDateSheet)
}
protocol PickedDateListChangedDelegate{
    func pickedDateListChanged(view: SelectedDateSheet)
}
class SelectedDateSheet: UIView {
    
    // MARK: - properties
    
    static let identifier: String = "SelectedDateSheet"
    
    var pickedDateList: [PickedDate] = [] {
        didSet{
            pickedDateListDelegate?.pickedDateListChanged(view: self)
        }
        willSet {
            dateTicketsStackView.removeAllSubViews()
            newValue.forEach {
                let dateTicketView: DateTicketView = DateTicketView()
                dateTicketView.delegate = self
                dateTicketView.pickedDate = $0
                dateTicketView.dateLabel.text = $0.getDateString()
                dateTicketView.timeLabel.text = $0.getStartToEndString()
                dateTicketsStackView.addArrangedSubview(dateTicketView)
               
            }
            updateStackViewHeight(by: newValue.count)
            selectedCountLabel.text = "\(newValue.count)/4"
        }
    }
    
    var tapTouchAreaViewDelegate: TapTouchAreaViewDelegate?
    var pickedDateListDelegate: PickedDateListChangedDelegate?
    
    private let grabber: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey02
        $0.layer.cornerRadius = 2
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.text = "선택한 날짜"
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.grey06
    }
    private let touchAreaView: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let selectedCountLabel: UILabel = UILabel().then {
        $0.text = "0/4"
        $0.textColor = UIColor.pink01
        $0.font = UIFont.dinProMediumFont(ofSize: 14)
    }
    
    private let dateTicketsStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        setGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayouts()
        setGestureRecognizer()
    }
    
    private func setLayouts() {
        isUserInteractionEnabled = true
        backgroundColor = .white
        layer.cornerRadius = 20
        getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: -3), shadowRadius: 3, shadowOpacity: 0.1)
        
        addSubviews([grabber, titleLabel,selectedCountLabel,touchAreaView,dateTicketsStackView])
        
        grabber.snp.makeConstraints {
            $0.height.equalTo(4 * heightRatio)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(29 * widthRatio)
            $0.top.equalToSuperview().offset(6 * heightRatio)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30 * heightRatio)
            $0.leading.equalToSuperview().offset(20 * widthRatio)
        }
        touchAreaView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        selectedCountLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(7 * widthRatio)
            $0.top.equalToSuperview().offset(31 * heightRatio)
        }
        
        dateTicketsStackView.snp.makeConstraints {
           // $0.width.equalTo(349 * widthRatio)
            $0.leading.equalToSuperview().offset(19 * widthRatio)
            $0.trailing.equalToSuperview().offset(-6 * widthRatio)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(73 * heightRatio)
        }
        
        // 임시!
//        dateTicketsStackView.addArrangedSubview(DateTicketView())
//        dateTicketsStackView.addArrangedSubview(DateTicketView())
//        dateTicketsStackView.addArrangedSubview(DateTicketView())
    }
    
    private func setGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTouchArea(gestureRecognizer:)))
        touchAreaView.addGestureRecognizer(tapRecognizer)
        touchAreaView.isUserInteractionEnabled = true
    }
//
    @objc func tapTouchArea(gestureRecognizer: UIGestureRecognizer){
        tapTouchAreaViewDelegate?.tapTouchAreaView(dateSheetView: self)


        }
//    
    // 스택뷰 갯수 바뀌고 마지막에 반드시 호출할 함수
    private func updateStackViewHeight(by count: Int) {
        dateTicketsStackView.snp.updateConstraints {
            $0.height.equalTo(73 * Double(count) * heightRatio)
        }
    }
    
    func addPickedDate(date: PickedDate){
        if(pickedDateList.count < 4){
            pickedDateList.append(date)
    
        }
       
    }
       
}

extension SelectedDateSheet: DateTicketViewDelegate {
    func dateTicketViewDelete(view: DateTicketView) {
        if let pickedDate = view.pickedDate,
           let ticketIndex = pickedDateList.firstIndex(where: { $0 == pickedDate }) {
                pickedDateList.remove(at: ticketIndex)
         
        }
    }
}
