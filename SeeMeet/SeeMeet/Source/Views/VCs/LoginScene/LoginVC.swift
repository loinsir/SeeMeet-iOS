import UIKit
import SnapKit
import Then
import SwiftUI

class LoginVC: UIViewController {
    
    private let LoginImageView = UIImageView().then{
        $0.image = UIImage(named: "img_seemeet_logo")
    }
    private let emailTextView = GrayTextView(type: .loginEmail)
    private let emailTextField = GrayTextField(type: .email, placeHolder: "이메일").then{
        $0.tag = 1
    }
    private let pwdTextView =  GrayTextView(type: .loginPassword)
    private let pwdTextField = GrayTextField(type: .password, placeHolder: "비밀번호").then{
        $0.tag = 2
    }
    private let pwdSeeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
        $0.addTarget(self, action: #selector(notSeeButtonClicked(_:)), for: .touchUpInside)
        $0.isHidden = true
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
        emailTextView.addSubview(emailTextField)
        pwdTextView.addSubviews([pwdTextField, pwdSeeButton])
        pwdTextField.delegate = self
        emailTextField.delegate = self
        
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
        emailTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(52)
            $0.top.bottom.equalTo(0)
            $0.width.equalTo(200)
        }
        pwdSeeButton.snp.makeConstraints{
            $0.trailing.top.bottom.equalToSuperview().offset(0)
            $0.width.equalTo(48)
        }
        pwdTextView.snp.makeConstraints{
            $0.top.equalTo(emailTextView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
        pwdTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(52)
            $0.top.bottom.equalTo(0)
            $0.width.equalTo(200)
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
        
    }
    
    
    
    var isNotSee: Bool = true
    var isFull: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginLayout()
    }
    
    @objc func notSeeButtonClicked(_ sender: UIButton) {
        print(pwdTextField.tag)
        if isNotSee == false{
            isNotSee = true
            pwdSeeButton.setBackgroundImage(UIImage(named: "ic_password_see"), for: .normal)
            pwdTextField.isSecureTextEntry = true
        }
        else{
            isNotSee = false
            pwdSeeButton.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
            pwdTextField.isSecureTextEntry = false
        }
    }

    
}

extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag{
        case 1:
            emailTextView.emailTextIamgeView.isHidden = true
            emailTextField.snp.remakeConstraints{
                $0.leading.equalToSuperview().offset(22)
                $0.top.bottom.equalToSuperview().offset(0)
                $0.width.equalTo(200)
            }
        case 2:
            pwdTextView.pwdTextImageView.isHidden = true
            pwdTextField.snp.remakeConstraints{
                $0.leading.equalToSuperview().offset(22)
                $0.top.bottom.equalToSuperview().offset(0)
                $0.width.equalTo(200)
            }
            pwdSeeButton.isHidden = false
        default:
            print("error")
        }

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag{
        case 1:
            if textField.text?.isEmpty == true{
                emailTextField.snp.remakeConstraints{
                    $0.top.bottom.equalToSuperview().offset(0)
                    $0.leading.equalToSuperview().offset(52)
                    $0.trailing.equalToSuperview().offset(-22)
                }
                emailTextField.attributedPlaceholder = String.getAttributedText(text: "이메일", letterSpacing: -0.6, lineSpacing: nil)
                emailTextView.emailTextIamgeView.isHidden = false
            }
        default:
            if textField.text?.isEmpty == true{
                pwdTextField.snp.remakeConstraints{
                    $0.top.bottom.equalToSuperview().offset(0)
                    $0.leading.equalToSuperview().offset(52)
                    $0.trailing.equalToSuperview().offset(-22)
                }
                pwdTextField.attributedPlaceholder = String.getAttributedText(text: "비밀번호", letterSpacing: -0.6, lineSpacing: nil)
                pwdTextView.pwdTextImageView.isHidden = false
                pwdSeeButton.isHidden = true
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
