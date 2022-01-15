import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 821
fileprivate let widthRatio = userWidth / 375

enum SMPopUpType {
    case needLogin // 메인뷰
    case deletePlans // 캘린더 상세 뷰
    case dismissRequest // 약속 신청 뷰
    case cancelPlans // 약속 내역 보낸 요청
    case refusePlans // 약속 내역 받은 요청
}

class SMPopUpVC: UIViewController {
    
    // MARK: - properties
    static let identifier: String = "SMPopUpVC"
    
    private var messageLabels: [UILabel] = []
    
    var greyButtonText: String? {
        didSet {
            greyButton.setTitle(oldValue, for: .normal)
        }
    }
    
    var pinkButtonText: String? {
        didSet {
            pinkButton.setTitle(oldValue, for: .normal)
        }
    }
    
    var type: SMPopUpType = .needLogin {
        didSet {
            setContents()
        }
    }
    
    private let popUpView: UIView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let greyButton: UIButton = UIButton().then {
        $0.setTitleColor(UIColor.grey05, for: .normal)
        $0.backgroundColor = UIColor.grey02
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.addTarget(self, action: #selector(touchUpGreyButton(_:)), for: .touchUpInside)
    }
    
    private let pinkButton: UIButton = UIButton().then {
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor.pink01
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.addTarget(self, action: #selector(touchUpPinkButton(_:)), for: .touchUpInside)
    }
    
    var pinkButtonCompletion: (() -> Void)?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setMessageLayout()
    }
    
    convenience init() {
        self.init()
        setContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setContents()
    }
    
    init(withType: SMPopUpType) {
        super.init(nibName: nil, bundle: nil)
        type = withType
        setContents()
    }
    
    private func setContents() {
        var messageText: [String] = []
        
        switch type {
        case .needLogin:
            messageText = ["로그인이 필요한 서비스에요", "로그인 하러 갈까요?"]
            greyButton.setTitle("취소", for: .normal)
            pinkButton.setTitle("로그인", for: .normal)
        case .deletePlans:
            messageText = ["정말 이 약속을 삭제할까요?"]
            greyButton.setTitle("취소", for: .normal)
            pinkButton.setTitle("삭제", for: .normal)
        case .dismissRequest:
            messageText = ["작성중인 내용이 있어요", "여기서 나갈까요?"]
            greyButton.setTitle("취소", for: .normal)
            pinkButton.setTitle("나가기", for: .normal)
        case .cancelPlans:
            messageText = ["약속을 취소하시겠어요?"]
            greyButton.setTitle("아니오", for: .normal)
            pinkButton.setTitle("예", for: .normal)
        case .refusePlans:
            messageText = ["약속을 거절하시겠어요?"]
            greyButton.setTitle("취소", for: .normal)
            pinkButton.setTitle("거절", for: .normal)
        }
        
        messageText.forEach {
            let label: UILabel = UILabel()
            label.font = UIFont.hanSansMediumFont(ofSize: 16)
            label.text = $0
            label.textColor = UIColor.black
            label.textAlignment = .center
            messageLabels.append(label)
        }
    }
    
    private func setLayouts() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        view.addSubview(popUpView)
        popUpView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(53 * widthRatio)
            $0.top.equalToSuperview().offset(317 * heightRatio)
            $0.width.equalTo(270 * widthRatio)
            $0.height.equalTo(167 * heightRatio)
        }
        
        popUpView.addSubviews([greyButton, pinkButton])
        
        greyButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(popUpView.snp.width).dividedBy(2)
            $0.height.equalTo(50 * heightRatio)
        }
        
        pinkButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(greyButton.snp.width)
            $0.height.equalTo(greyButton.snp.height)
        }
    }
    
    private func setMessageLayout() {
        popUpView.addSubviews(messageLabels)
        
        switch type {
        case .deletePlans, .cancelPlans, .refusePlans:
            if let messageLabel = messageLabels.first {
                messageLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(52 * heightRatio)
                    $0.centerX.equalToSuperview()
                }
            }
        case .needLogin, .dismissRequest:
            if let messageLabelFirst = messageLabels.first,
                let messageLabelLast = messageLabels.last {
                messageLabelFirst.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(33 * heightRatio)
                    $0.leading.equalToSuperview().offset(12 * widthRatio)
                    $0.trailing.equalToSuperview().offset(-12 * widthRatio)
                }
                
                messageLabelLast.snp.makeConstraints {
                    $0.top.equalTo(messageLabelFirst.snp.bottom).offset(10 * heightRatio)
                    $0.leading.equalToSuperview().offset(12 * widthRatio)
                    $0.trailing.equalToSuperview().offset(-12 * widthRatio)
                }
            }
        }
    }
    
    // MARK: - objc
    
    @objc func touchUpGreyButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func touchUpPinkButton(_ sender: UIButton) {
        guard let completion = pinkButtonCompletion else { return }
        completion()
    }
}
