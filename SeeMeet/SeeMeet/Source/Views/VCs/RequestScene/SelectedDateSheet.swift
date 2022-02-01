import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812
fileprivate let widthRatio = userWidth / 375

class SelectedDateSheet: UIView {
    
    // MARK: - properties
    
    static let identifier: String = "SelectedDateSheet"
    
    var pickedDateList: [PickedDate] = [] {
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
    
    // Snap 효과를 위한 케이스
    enum SheetViewState {
        case expanded
        case folded
    }
    
    // 퍌친 상태 Top
    private lazy var sheetPanMinTopConstant: CGFloat = 812 - 482 * heightRatio
    // 접힌 상태 Top
    private lazy var sheetPanMaxTopConstant: CGFloat = 812 - 172 * heightRatio
    // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var sheetPanStartingTopConstant: CGFloat = frame.origin.y
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        setPanGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayouts()
        setPanGestureRecognizer()
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
    }
    
    private func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) }) else { return number }
        return nearestVal
    }
    
    private func setPanGestureRecognizer(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(processingPanGesture(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }
    
    @objc private func processingPanGesture(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: self)
        
        switch sender.state {
        case .began:
            sheetPanStartingTopConstant = frame.origin.y
        case .changed:
            if sheetPanStartingTopConstant + transition.y > sheetPanMinTopConstant {
                frame = CGRect(x: 0, y: sheetPanStartingTopConstant + transition.y, width: frame.width, height: frame.height)
            }
        case .ended:
            let nearestValue = nearest(to: frame.origin.y, inValues: [sheetPanMinTopConstant, sheetPanMaxTopConstant])
            
            if nearestValue == sheetPanMinTopConstant { // 시트를 펼쳐야 한다
                showSheet(atState: .expanded)
            } else { // 시트를 접어야 한다
                showSheet(atState: .folded)
            }
        default:
            break
        }
    }
    
    func showSheet(atState: SheetViewState = .folded) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
            if atState == .folded {
                self.frame = CGRect(x: 0, y: self.sheetPanMaxTopConstant, width: self.frame.width, height: self.frame.height)
            } else {
                self.frame = CGRect(x: 0, y: self.sheetPanMinTopConstant, width: self.frame.width, height: self.frame.height)
            }
        }, completion: { _ in // 바뀐 시트 상태로 오토레이아웃을 업데이트 시킨다. 해주지 않으면 티켓 뷰 추가시 강제로 내려가는 버그 발생.
            let currentTop = self.frame.minY
            self.snp.remakeConstraints {
                $0.top.equalTo(currentTop)
                $0.trailing.leading.equalToSuperview()
                $0.height.equalTo(482 * heightRatio)
            }
        })
    }

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

// MARK: - extensions

extension SelectedDateSheet: DateTicketViewDelegate {
    func dateTicketViewDelete(view: DateTicketView) {
        if let pickedDate = view.pickedDate,
           let ticketIndex = pickedDateList.firstIndex(where: { $0 == pickedDate }) {
                pickedDateList.remove(at: ticketIndex)
        }
    }
}
