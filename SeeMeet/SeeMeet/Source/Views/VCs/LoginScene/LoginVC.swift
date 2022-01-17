import UIKit
import SnapKit
import Then

class LoginVC: UIViewController {
    
    private let LoginImageView = UIImageView().then{
        $0.image = UIImage(named: "img_seemeet_logo")
    }
    private let emailTextView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let emailTextIamgeView = UIImageView().then{
        $0.image = UIImage(named: "ic_e-mail")
    }
    private let emailTextField = UITextField().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.tag = 1
        $0.textColor = UIColor.grey06
        $0.contentVerticalAlignment = .center
        $0.attributedPlaceholder = String.getAttributedText(text: "이메일", letterSpacing: -0.6, lineSpacing: nil)
        $0.tintColor = UIColor.pink01
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    private let pwdTextView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let pwdTextImageView = UIImageView().then{
        $0.image = UIImage(named: "ic_password")
    }
    private let pwdTextField = UITextField().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.tag = 2
        $0.textColor = UIColor.grey06
        $0.contentVerticalAlignment = .center
        $0.isSecureTextEntry = true
        $0.attributedPlaceholder = String.getAttributedText(text: "비밀번호", letterSpacing: -0.6, lineSpacing: nil)
        $0.isSecureTextEntry = true
        $0.tintColor = UIColor.pink01
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    private let pwdSeeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
        $0.addTarget(self, action: #selector(notSeeButtonClicked(_:)), for: .touchUpInside)
    }
    private let loginButton = UIButton().then{
        $0.backgroundColor = UIColor.grey04
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    private let accountButton = UIImageView().then{
        $0.image = UIImage(named: "btn_sign-up")
    }
    
    func setLoginLayout(){
        view.backgroundColor = UIColor.white
        view.addSubviews([LoginImageView, emailTextView, pwdTextView, loginButton, accountButton])
        emailTextView.addSubviews([emailTextIamgeView, emailTextField])
        pwdTextView.addSubviews([pwdTextImageView, pwdTextField, pwdSeeButton])
        emailTextField.delegate = self
        pwdTextField.delegate = self
        LoginImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(158)
        }
        emailTextView.snp.makeConstraints{
            $0.top.equalTo(LoginImageView.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
        emailTextIamgeView.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview().offset(0)
            $0.width.equalTo(48)
        }
        emailTextField.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().offset(0)
            $0.leading.equalTo(emailTextIamgeView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-22)
        }
        pwdTextView.snp.makeConstraints{
            $0.top.equalTo(emailTextView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
        pwdTextImageView.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview().offset(0)
            $0.width.equalTo(48)
        }
        pwdTextField.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().offset(0)
            $0.leading.equalTo(pwdTextImageView.snp.trailing).offset(0)
            $0.trailing.equalToSuperview().offset(-22)
        }
        loginButton.snp.makeConstraints{
            $0.top.equalTo(pwdTextView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(54)
        }
        accountButton.snp.makeConstraints{
            $0.top.equalTo(loginButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(129)
            $0.height.equalTo(32)
        }
        pwdSeeButton.snp.makeConstraints{
            $0.top.bottom.trailing.equalToSuperview().offset(0)
            $0.width.equalTo(48)
        }
        pwdSeeButton.isHidden = true
        
    }
    
    
    @objc private func notSeeButtonClicked(_ sender: UIButton){
        if isNotSee == true{
            isNotSee = false
            pwdSeeButton.setBackgroundImage(UIImage(named: "ic_password_see"), for: .normal)
            pwdTextField.isSecureTextEntry = false
        }
        else{
            isNotSee = true
            pwdSeeButton.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
            pwdTextField.isSecureTextEntry = true
        }
     }

    var isNotSee: Bool = true
    var isFull: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginLayout()

    }
    
}

extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag{
        case 1:
            emailTextIamgeView.isHidden = true
            emailTextField.snp.remakeConstraints{
                $0.top.bottom.equalToSuperview().offset(0)
                $0.leading.equalToSuperview().offset(22)
                $0.trailing.equalToSuperview().offset(-22)
            }
            textField.placeholder = ""
            
        default:
            pwdTextImageView.isHidden = true
            pwdSeeButton.isHidden = false
            pwdTextField.snp.remakeConstraints{
                $0.top.bottom.equalToSuperview().offset(0)
                $0.leading.equalToSuperview().offset(22)
                $0.trailing.equalToSuperview().offset(-22)
            }
            textField.placeholder = ""
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag{
        case 1:
            if textField.text?.isEmpty == true{
                emailTextIamgeView.isHidden = false
                emailTextField.snp.remakeConstraints{
                    $0.top.bottom.equalToSuperview().offset(0)
                    $0.leading.equalTo(emailTextIamgeView.snp.trailing).offset(4)
                    $0.trailing.equalToSuperview().offset(-22)
                }
                emailTextField.attributedPlaceholder = String.getAttributedText(text: "이메일", letterSpacing: -0.6, lineSpacing: nil)
            }
        default:
            if textField.text?.isEmpty == true{
                pwdTextImageView.isHidden = false
                pwdTextField.snp.remakeConstraints{
                    $0.top.bottom.equalToSuperview().offset(0)
                    $0.leading.equalTo(pwdTextImageView.snp.trailing).offset(4)
                    $0.trailing.equalToSuperview().offset(-22)
                }
                pwdTextField.attributedPlaceholder = String.getAttributedText(text: "비밀번호", letterSpacing: -0.6, lineSpacing: nil)
            }
        }
    }
    @objc func textFieldDidChange(_ sender: Any?) {
        if pwdTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false{
            loginButton.backgroundColor = UIColor.pink01
            isFull = true
        }
        else{
            isFull = false
            loginButton.backgroundColor = UIColor.grey04
        }
        print(isFull)
    }
}
