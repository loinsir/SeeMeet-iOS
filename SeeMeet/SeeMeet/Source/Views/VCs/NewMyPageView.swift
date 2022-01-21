import UIKit
class NewMyPage: UIView {
    
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight()
    
    private let profileImageView = UIImageView().then{
        $0.image = UIImage(named: "img_profile")
    }
    private let closeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_close_white"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
    }
    let nameLabel = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont.hanSansBoldFont(ofSize: 20)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.addTarget(self, action: #selector(HomeVC.gotoLoginVC(_:)), for: .touchUpInside)
    }
    private let arrowImage = UIImageView().then{
        $0.image = UIImage(named: "ic_mypage_login")
    }
    let emailTextLabel = UILabel().then{
        $0.text = "SeeMeet에서 친구와 약속을 잡아보세요!"
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.white
    }
    private let dummyImageView = UIImageView().then{
        $0.image = UIImage(named: "my_page")
        
    }
    
    func setLayout(){
        addSubviews([profileImageView, closeButton, nameLabel, arrowImage, emailTextLabel, dummyImageView])
        self.backgroundColor = UIColor.black
        profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(94)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(46)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(48)
            $0.trailing.equalToSuperview().offset(-4)
            $0.width.height.equalTo(48)
        }
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(24)
            $0.width.equalTo(60)
        }
        arrowImage.snp.makeConstraints{
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(0)
            $0.width.equalTo(27)
            $0.height.equalTo(48)
        }
        emailTextLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(300)
            $0.height.equalTo(20)
        }
        dummyImageView.snp.makeConstraints{
            $0.top.equalTo(emailTextLabel.snp.bottom).offset(33)
            $0.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeButtonClicked(_ sender: UIButton){
        UIView.animate(withDuration: 1.0){
            let yFrame = CGAffineTransform(translationX: -self.userWidth * 0.84, y: 0)
            self.transform = yFrame
        }
    }
   
}
