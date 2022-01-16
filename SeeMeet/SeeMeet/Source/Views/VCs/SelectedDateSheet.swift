import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 812
fileprivate let widthRatio = userWidth / 375

class SelectedDateSheet: UIView {
    
    // MARK: - properties
    
    static let identifier: String = "SelectedDateSheet"
    
    private let grabber: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey02
        $0.layer.cornerRadius = 2
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.text = "선택한 날짜"
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.grey06
    }
    
    private let selectedCountLabel: UILabel = UILabel().then {
        $0.text = "0/4"
        $0.textColor = UIColor.pink01
        $0.font = UIFont.dinProMediumFont(ofSize: 14)
    }
    
    private let dateTicketsStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    private let separator: UIView = UIView().then {
        $0.backgroundColor = UIColor.grey02
    }
    
    private let requestButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor.pink01
        let attributedtext = UILabel().setTextFontAttribute(defaultText: "약속 신청", containText: "약속 신청", changingFont: UIFont.hanSansMediumFont(ofSize: 16), color: UIColor.white)
        $0.setAttributedTitle(attributedtext, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayouts()
    }
    
    private func setLayouts() {
        isUserInteractionEnabled = true
        backgroundColor = .white
        layer.cornerRadius = 20
        addSubviews([grabber, titleLabel, selectedCountLabel, dateTicketsStackView, requestButton, separator])
        
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
        
        selectedCountLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(7 * widthRatio)
            $0.top.equalToSuperview().offset(31 * heightRatio)
        }
        
        dateTicketsStackView.snp.makeConstraints {
            $0.width.equalTo(349 * widthRatio)
            $0.height.equalTo(292 * heightRatio)
            $0.leading.equalToSuperview().offset(19 * widthRatio)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        // 임시!
        dateTicketsStackView.addArrangedSubview(DateTicketView())
        dateTicketsStackView.addArrangedSubview(DateTicketView())
        dateTicketsStackView.addArrangedSubview(DateTicketView())
        dateTicketsStackView.addArrangedSubview(DateTicketView())
    }

}
