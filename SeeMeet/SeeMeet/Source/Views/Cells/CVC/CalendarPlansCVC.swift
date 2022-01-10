import UIKit

class CalendarPlansCVC: UICollectionViewCell {
    
    // MARK: - properties
    
    static let identifier: String = "CalendarPlansCVC"
    
    var isSchedule: Bool = false {
        didSet {
            if isSchedule {
                nameLabelStackView = nil
                headerView.backgroundColor = UIColor.grey04
            }
        }
    }
    
    private let headerView: UIView = UIView().then {
        $0.layer.cornerRadius = CGFloat(10.0)
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.backgroundColor = UIColor.black // grey06으로 수정 필요
    }
    
    let headerTitle: UILabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14.0)
    }
    
    let hourLabel: UILabel = UILabel().then {
        $0.textColor = .grey05 // grey06으로 수정 필요
        $0.font = UIFont(name: "DINPro-Regular", size: 14.0)
        $0.text = "오전 11:00"
    }
    
    private lazy var nameLabelStackView: UIStackView? = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 6
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    var namesToShow: [String] = ["김인환", "김인환", "김인환"]
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        setBaseViewLayouts()
        setContentViewLayouts()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBaseViewLayouts()
        setContentViewLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBaseViewLayouts()
        setContentViewLayouts()
    }
    
    // MARK: - layout
    
    private func setBaseViewLayouts() {
        //shadow 추가 필요
        layer.cornerRadius = CGFloat(10.0)
        backgroundColor = UIColor.white
        
        addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(17)
        }
    }
    
    private func setContentViewLayouts() {
        
        addSubview(hourLabel)
        hourLabel.snp.makeConstraints {
            if isSchedule {
                $0.leading.equalToSuperview().offset(37)
                $0.top.equalTo(headerView.snp.bottom).offset(31)
            } else {
                $0.leading.equalToSuperview().offset(22)
                $0.top.equalTo(headerView.snp.bottom).offset(17)
            }
        }
        
        if isSchedule {
            hourLabel.font = UIFont(name: "DINPro-Regular", size: 16.0)
        } else {

            guard let nameLabelStackView = nameLabelStackView else { return }

            addSubview(nameLabelStackView)
            nameLabelStackView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(12)
                $0.top.equalTo(hourLabel.snp.bottom).offset(4)
                $0.width.equalTo(200)
                $0.height.equalTo(45)
            }
            
            namesToShow.forEach {
                let nameLabel: UILabel = UILabel()
                nameLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12.0)
                nameLabel.textColor = UIColor.pink01
                nameLabel.text = $0
                nameLabel.sizeToFit()
                nameLabel.clipsToBounds = true
                nameLabel.layer.cornerRadius = 12
                nameLabel.layer.borderWidth = 1
                nameLabel.layer.borderColor = UIColor.pink01.cgColor
                nameLabel.textAlignment = .center
                nameLabelStackView.addArrangedSubview(nameLabel)
            }
        }
    }

}
