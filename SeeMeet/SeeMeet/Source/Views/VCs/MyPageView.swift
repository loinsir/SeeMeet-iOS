import UIKit
import SnapKit

fileprivate let userHeight: CGFloat = UIScreen.getDeviceHeight()
fileprivate let userWidth: CGFloat = UIScreen.getDeviceWidth()
fileprivate let heightRatio: CGFloat = userHeight / 812
fileprivate let widthRatio: CGFloat = userWidth / 375

class MyPageView: UIView {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var loginArrowButton: UIButton!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var listImage: UIImageView!
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        setLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        setLayouts()
    }
    
    // MARK: - method
    private func configUI() {
        userNameLabel.font = UIFont.hanSansBoldFont(ofSize: 20)
        userEmailLabel.font = UIFont.hanSansMediumFont(ofSize: 14)
    }
    
    private func setLayouts() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(46 * widthRatio)
            $0.leading.equalTo(20 * widthRatio)
            $0.bottom.equalToSuperview().offset(-100 * heightRatio)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20 * widthRatio)
            $0.top.equalTo(14 * heightRatio)
        }
        
        loginArrowButton.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing)
            $0.width.equalTo(27 * widthRatio)
            $0.height.equalTo(48 * heightRatio)
            $0.centerY.equalTo(userNameLabel.snp.centerY)
        }
        
        userEmailLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-33 * heightRatio)
            $0.leading.equalTo(userNameLabel.snp.leading)
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(48 * widthRatio)
            $0.trailing.equalToSuperview().offset(-4 * widthRatio)
            $0.bottom.equalToSuperview().offset(-144 * heightRatio)
        }
        
        listImage.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(userEmailLabel.snp.bottom).offset(33 * heightRatio)
        }
    }
    
    private func loadXib() {
        let identifier: String = String(describing: (type(of: self)))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        
        guard let customView = nibs?.first as? UIView else { return }
        
        customView.frame = bounds
        addSubview(customView)
    }
    
    @IBAction func touchCloseButton(_ sender: UIButton) {
    }
}
