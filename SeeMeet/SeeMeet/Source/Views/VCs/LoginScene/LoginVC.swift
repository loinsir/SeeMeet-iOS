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
        
        view.dismissKeyboardWhenTappedAround()
        
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
            $0.trailing.equalToSuperview().offset(-5)
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
            $0.trailing.equalToSuperview().offset(-5)
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
        autoLogin()
        setLoginLayout()
    }
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,50}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
    }
    
    @objc func notSeeButtonClicked(_ sender: UIButton) {
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
        if isFull == true {
            PostLoginService.shared.login(email: emailTextField.text ?? "", password: pwdTextField.text ?? ""){ (response) in
                switch(response)
                {
                case .success(let success):
                    if let success = success as? RegisterDataModel {
                        if success.status == 404 {
                            self.view.makeToastAnimation(message: success.message)
                        }
                        else{
                            //토큰 저장하기~
                            UserDefaults.standard.set(true, forKey: "isLogin")
                            UserDefaults.standard.set(success.data?.user.username, forKey: "userName")
                            UserDefaults.standard.set(success.data?.user.email, forKey: "userEmail")
                            let accessToken = success.data?.accesstoken as! String
                            let tk = TokenUtils()
                            tk.create("accesstoken", account: "accessToken", value: accessToken)
                            
                            guard let homeVC = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "TabbarVC") as? TabbarVC else {return}
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }
                    }
                case .requestErr(let message) :
                    print("requestERR", message)
                case .pathErr :
                    print("pathERR")
                case .serverErr:
                    print("serverERR")
                case .networkFail:
                    print("networkFail")
                }
            }
        }
     }
    @objc private func accountButtonClicked(_ sender: UITapGestureRecognizer){
        guard let accountVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC else {return}
        self.navigationController?.pushViewController(accountVC, animated: true)
     }
    func autoLogin(){
        if UserDefaults.standard.bool(forKey: "isLogin") == true{
            guard let homeVC = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "TabbarVC") as? TabbarVC else {return}
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
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
        if pwdTextField.text?.isEmpty == false && isValidEmail(testStr: emailTextField.text ?? ""){
            if pwdTextField.text?.count ?? 0 >= 8 {
            loginButton.backgroundColor = UIColor.pink01
            isFull = true
            }
        }
        else{
            isFull = false
            loginButton.backgroundColor = UIColor.grey04
        }
    }
}
