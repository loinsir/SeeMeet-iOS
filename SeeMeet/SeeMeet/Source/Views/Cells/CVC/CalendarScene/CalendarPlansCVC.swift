import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 821
fileprivate let widthRatio = userWidth / 375

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
        $0.backgroundColor = UIColor.grey06
    }
    
    let headerTitle: UILabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14.0)
    }
    
    let hourLabel: UILabel = UILabel().then {
        $0.textColor = .grey06
        $0.font = UIFont(name: "DINPro-Regular", size: 14.0)
        $0.text = "오전 11:00"
    }
    
    private lazy var nameLabelStackView: UIStackView? = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 6 * widthRatio
        $0.layoutMargins = UIEdgeInsets(top: 10 * heightRatio, left: 10 * widthRatio, bottom: 10 * heightRatio, right: 10 * widthRatio)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    var namesToShow: [String] = ["김인환", "김인환", "김인환"]
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 4), shadowRadius: 3, shadowOpacity: 0.25)
        setBaseViewLayouts()
        setContentViewLayouts()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 4), shadowRadius: 3, shadowOpacity: 0.25)
        setBaseViewLayouts()
        setContentViewLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 4), shadowRadius: 3, shadowOpacity: 0.25)
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
            $0.height.equalTo(52 * heightRatio)
        }
        
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22 * widthRatio)
            $0.top.equalToSuperview().offset(17 * heightRatio)
        }
    }
    
    private func setContentViewLayouts() {
        
        addSubview(hourLabel)
        hourLabel.snp.makeConstraints {
            if isSchedule {
                $0.leading.equalToSuperview().offset(37 * widthRatio)
                $0.top.equalTo(headerView.snp.bottom).offset(31 * heightRatio)
            } else {
                $0.leading.equalToSuperview().offset(22 * widthRatio)
                $0.top.equalTo(headerView.snp.bottom).offset(17 * heightRatio)
            }
        }
        
        if isSchedule {
            hourLabel.font = UIFont(name: "DINPro-Regular", size: 16.0)
        } else {

            guard let nameLabelStackView = nameLabelStackView else { return }

            addSubview(nameLabelStackView)
            nameLabelStackView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(12 * widthRatio)
                $0.top.equalTo(hourLabel.snp.bottom).offset(4 * heightRatio)
                $0.width.equalTo(200 * widthRatio)
                $0.height.equalTo(45 * heightRatio)
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
