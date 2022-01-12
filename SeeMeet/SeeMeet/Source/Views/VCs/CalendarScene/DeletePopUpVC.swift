import UIKit

fileprivate let userHeight = UIScreen.getDeviceHeight() - 0.0
fileprivate let userWidth = UIScreen.getDeviceWidth() - 0.0
fileprivate let heightRatio = userHeight / 821
fileprivate let widthRatio = userWidth / 375

class DeletePopUpVC: UIViewController {
    
    // MARK: - properties
    
    private let popUpView: UIView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let messageLabel: UILabel = UILabel().then {
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.black
        $0.text = "정말 이 약속을 삭제할까요?"
        $0.textAlignment = .center
    }
    
    private let cancelButton: UIButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor.grey05, for: .normal)
        $0.backgroundColor = UIColor.grey02
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
    }
    
    private let deleteButton: UIButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor.pink01
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.addTarget(self, action: #selector(touchUpDeleteButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
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
        
        popUpView.addSubviews([messageLabel, cancelButton, deleteButton])
        
        messageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45 * heightRatio)
            $0.leading.equalToSuperview().offset(12 * widthRatio)
            $0.trailing.equalToSuperview().offset(-12 * widthRatio)
            $0.bottom.equalTo(-90 * heightRatio)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(popUpView.snp.width).dividedBy(2)
            $0.height.equalTo(50 * heightRatio)
        }
        
        deleteButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(cancelButton.snp.width)
            $0.height.equalTo(cancelButton.snp.height)
        }
    }
    
    @objc func touchUpCancelButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func touchUpDeleteButton(_ sender: UIButton) {
        
    }

}
