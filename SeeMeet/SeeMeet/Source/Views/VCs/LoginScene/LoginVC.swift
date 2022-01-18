import UIKit
import SnapKit
import Then

class LoginVC: UIViewController {
    
    private let LoginImageView = UIImageView().then{
        $0.image = UIImage(named: "img_seemeet_logo")
    }
    private let emailTextView = GrayTextView(type: .loginEmail)
    private let emailTextField = GrayTextField(type: .email, placeHolder: "이메일").then{
        $0.tag = 1
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    private let pwdTextView =  GrayTextView(type: .loginPassword)
    private let pwdTextField = GrayTextField(type: .password, placeHolder: "비밀번호").then{
        $0.tag = 2
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        $0.addTarget(self, action: #selector(loginButtonClicked(_:)), for: .touchUpInside)
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(accountButtonClicked(_ :)))
        accountButton.isUserInteractionEnabled = true
        accountButton.addGestureRecognizer(gesture)
    }

    //원래 비밀번호 상태 true가 디폴트
    var isNotSee: Bool = true
    var isFull: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginLayout()
    }
    
    @objc func notSeeButtonClicked(_ sender: UIButton) {
        print(pwdTextField.tag)
        if isNotSee == true{
            isNotSee = false
            pwdSeeButton.setBackgroundImage(UIImage(named: "ic_password_see"), for: .normal)
            pwdTextField.isSecureTextEntry = isNotSee
        }
        else{
            isNotSee = true
            pwdSeeButton.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
            pwdTextField.isSecureTextEntry = isNotSee
        }
    }
    @objc private func loginButtonClicked(_ sender: UIButton){
        guard let homeVC = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "TabbarVC") as? TabbarVC else {return}
        if isFull == true {
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
     }
    @objc private func accountButtonClicked(_ sender: UITapGestureRecognizer){
        guard let accountVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC else {return}
        self.navigationController?.pushViewController(accountVC, animated: true)
        print("??")
     }
    
}

extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 2{
            pwdSeeButton.isHidden = false
        }

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 2{
            if textField.text?.isEmpty == true{
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
