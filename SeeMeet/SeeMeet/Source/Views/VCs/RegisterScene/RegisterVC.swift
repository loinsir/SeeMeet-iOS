//
//  RegisterVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/18.
//

import UIKit
import SnapKit
import Then

class RegisterVC: UIViewController {
    private let scrollBackgroundView = UIScrollView().then{
        $0.isPagingEnabled = false
        $0.bounces = true
        $0.contentSize = CGSize(width: UIScreen.getDeviceWidth(), height: 0)
        $0.backgroundColor = UIColor.white
        $0.showsVerticalScrollIndicator = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let headerView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let backButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "btn_back"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked(_:)), for: .touchUpInside)
    }
    private let headLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 24)
        $0.textColor = UIColor.grey06
        $0.attributedText = $0.setTextLineAttribute(defaultText: "회원가입", value: -0.6)
    }
    //name
    private let nameView = UIView().then{
        $0.backgroundColor = .none
    }
    private let nameViewheadLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.attributedText = $0.setTextLineAttribute(defaultText: "이름", value: -0.6)
    }
    private let nameTextView = GrayTextView(type: .register)
    private let nameTextField = GrayTextField(type: .email, placeHolder: "이름")
    //email
    private let emailView = UIView().then{
        $0.backgroundColor = .none
    }
    private let emailViewheadLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.attributedText = $0.setTextLineAttribute(defaultText: "이메일", value: -0.6)
    }
    private let emailTextView = GrayTextView(type: .register)
    private let emailTextField = GrayTextField(type: .email, placeHolder: "이메일")
    private let emailWarningLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 12)
        $0.textColor = UIColor.red
        $0.attributedText = $0.setTextLineAttribute(defaultText: "올바른 이메일을 입력해주세요.", value: -0.6)
    }
    //password
    private let passwordView = UIView().then{
        $0.backgroundColor = .none
    }
    private let passwordViewheadLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.attributedText = $0.setTextLineAttribute(defaultText: "비밀번호", value: -0.6)
    }
    private let passwordTextView = GrayTextView(type: .register)
    private let passwordTextField = GrayTextField(type: .password, placeHolder: "비밀번호").then{
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    private let seePasswordButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
        $0.addTarget(self, action: #selector(seePasswordButtonClicked(_:)), for: .touchUpInside)
    }
    private let passwordWarningLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 12)
        $0.textColor = UIColor.red
        $0.attributedText = $0.setTextLineAttribute(defaultText: "8자 이상의 비밀번호를 입력해주세요.", value: -0.6)
    }
    //passwordConfirm
    private let confirmView = UIView().then{
        $0.backgroundColor = .none
    }
    private let confirmViewheadLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.attributedText = $0.setTextLineAttribute(defaultText: "비밀번호 확인", value: -0.6)
    }
    private let confirmTextView = GrayTextView(type: .register)
    private let confirmTextField = GrayTextField(type: .password, placeHolder: "비밀번호 확인")
    private let confirmWarningLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 12)
        $0.textColor = UIColor.red
        $0.attributedText = $0.setTextLineAttribute(defaultText: "비밀번호가 일치하지 않아요", value: -0.6)
    }
    private let seeConfirmButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
        $0.addTarget(self, action: #selector(seeConfirmButtonClicked(_:)), for: .touchUpInside)
    }
    //bottomView
    private let backbuttonView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    private let topview = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    private let registerButton = UIButton().then{
        $0.backgroundColor = UIColor.grey02
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.setTitle("회원가입", for: .normal)
        $0.addTarget(self, action: #selector(registerButtonClicked(_:)), for: .touchUpInside)
    }
    func setRegisterLayout(){
        view.addSubviews([scrollBackgroundView, headerView])
        scrollBackgroundView.addSubviews([headLabel, nameView, emailView, passwordView, confirmView, backbuttonView])
        headerView.addSubview(backButton)
        nameView.addSubviews([nameViewheadLabel, nameTextView])
        nameTextView.addSubview(nameTextField)
        backbuttonView.addSubviews([registerButton, topview])
                
        emailView.addSubviews([emailViewheadLabel, emailTextView, emailWarningLabel])
        emailTextView.addSubview(emailTextField)
        
        passwordView.addSubviews([passwordViewheadLabel, passwordTextView, passwordWarningLabel])
        passwordTextView.addSubviews([passwordTextField, seePasswordButton])
        
        confirmView.addSubviews([confirmViewheadLabel, confirmTextView, confirmWarningLabel])
        confirmTextView.addSubviews([confirmTextField, seeConfirmButton])
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        emailWarningLabel.isHidden = true
        passwordWarningLabel.isHidden = true
        confirmWarningLabel.isHidden = true
        
        view.dismissKeyboardWhenTappedAround()
        
        headerView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(102)
        }
        scrollBackgroundView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        backButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(49)
            $0.leading.equalToSuperview().offset(2)
            $0.width.height.equalTo(48)
        }
        headLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(90)
        }
        nameView.snp.makeConstraints{
            $0.top.equalTo(headLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(103)
        }
        nameViewheadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(0)
            $0.width.equalTo(30)
        }
        nameTextView.snp.makeConstraints{
            $0.top.equalTo(nameViewheadLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(50)
        }
        nameTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.bottom.trailing.equalToSuperview().offset(0)
        }
        emailView.snp.makeConstraints{
            $0.top.equalTo(nameView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(103)
        }
        emailViewheadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(0)
            $0.width.equalTo(50)
        }
        emailTextView.snp.makeConstraints{
            $0.top.equalTo(emailViewheadLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.bottom.trailing.equalToSuperview().offset(0)
        }
        emailWarningLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(1)
            $0.width.equalTo(150)
        }

        passwordView.snp.makeConstraints{
            $0.top.equalTo(emailView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(103)
        }
        passwordViewheadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(0)
            $0.width.equalTo(50)
        }
        passwordTextView.snp.makeConstraints{
            $0.top.equalTo(passwordViewheadLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.bottom.equalToSuperview().offset(0)
            $0.trailing.equalTo(seePasswordButton.snp.leading).offset(0)
        }
        passwordWarningLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(1)
            $0.width.equalTo(250)
        }
        seePasswordButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.width.equalTo(48)
        }
        
        confirmView.snp.makeConstraints{
            $0.top.equalTo(passwordView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(103)
        }
        confirmViewheadLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(0)
            $0.width.equalTo(200)
        }
        confirmTextView.snp.makeConstraints{
            $0.top.equalTo(confirmViewheadLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(50)
        }
        confirmTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.bottom.equalToSuperview().offset(0)
            $0.trailing.equalTo(seeConfirmButton.snp.leading).offset(0)
        }
        confirmWarningLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(1)
            $0.width.equalTo(150)
        }
        seeConfirmButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.width.equalTo(48)
        }
        backbuttonView.snp.makeConstraints{
            $0.top.equalTo(confirmView.snp.bottom).offset(51)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(view.snp.trailing).offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.height.equalTo(112)
        }
        registerButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(54)
        }
        topview.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(1)
        }
    }
    private var isConfirmNotSee = true
    private var isPasswordNotSee = true
    private var emailBool: Bool = false
    private var pwdBool: Bool = false
    private var pwdCheckBool: Bool = false
    private var buttonOn: Bool = false
    private var isKeboardShow: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegisterLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,50}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
    }
    func isValidPassword(testStr:String, regEx: [String]) -> [Bool]{
        var passwordStatus: [Bool] = []
        for reg in regEx{
            let passwordRegEx = reg
            let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            passwordStatus.append(passwordTest.evaluate(with: testStr))
        }
        return passwordStatus
    }
    func isButtonOn(){
        if !(nameTextField.text?.isEmpty ?? true) && emailBool && pwdBool && pwdCheckBool {
            buttonOn = true
            registerButton.backgroundColor = UIColor.pink01
        }
        else{
            buttonOn = false
            registerButton.backgroundColor = UIColor.grey02
        }
    }
    @objc func seeConfirmButtonClicked(_ sender: UIButton) {
        if isConfirmNotSee == true{
            isConfirmNotSee = false
            seeConfirmButton.setBackgroundImage(UIImage(named: "ic_password_see"), for: .normal)
            confirmTextField.isSecureTextEntry = isConfirmNotSee
        }
        else{
            isConfirmNotSee = true
            seeConfirmButton.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
            confirmTextField.isSecureTextEntry = isConfirmNotSee
        }
    }
    @objc func seePasswordButtonClicked(_ sender: UIButton) {
        if isPasswordNotSee == true{
            isPasswordNotSee = false
            seePasswordButton.setBackgroundImage(UIImage(named: "ic_password_see"), for: .normal)
            passwordTextField.isSecureTextEntry = isPasswordNotSee
        }
        else{
            isPasswordNotSee = true
            seePasswordButton.setBackgroundImage(UIImage(named: "ic_password_notsee"), for: .normal)
            passwordTextField.isSecureTextEntry = isPasswordNotSee
        }
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        if isKeboardShow == false {
            view.frame.origin.y -= 150
            isKeboardShow = true
        }
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        if isKeboardShow == true{
            view.frame.origin.y += 150
            isKeboardShow = false
        }
    }
    func overlappingEmail(){
        emailWarningLabel.isHidden = false
        emailTextView.layer.borderWidth = 1
        emailTextView.layer.borderColor = UIColor.red.cgColor
        emailWarningLabel.text = "이미 등록된 이메일이에요."
        emailBool = false
    }
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func registerButtonClicked(_ sender: UIButton) {
        if buttonOn {
        PostRegisterService.shared.register(username: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", passwordConfirm: confirmTextField.text ?? ""){ (response) in
            switch(response)
            {
            case .success(let success):
                if let success = success as? RegisterDataModel {
                    if success.status == 404{
                        self.overlappingEmail()
                    }
                    else if success.status == 200{
                        //토큰 저장하기~
                        let accessToken = success.data?.accesstoken as! String
                        let tk = TokenUtils()
                        //accesstoken으로 통일 ㄱㄱ
                        tk.create("accesstoken", account: "accessToken", value: accessToken)
                        /*
                         tk.read(Constants.registerURL, account: "accessToken")
                         */
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

}

extension RegisterVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField{
            emailTextView.layer.borderWidth = 0
            emailWarningLabel.isHidden = true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case emailTextField:
            if !isValidEmail(testStr: emailTextField.text ?? ""){
                emailTextView.layer.borderWidth = 1
                emailTextView.layer.borderColor = UIColor.red.cgColor
                emailWarningLabel.text = "올바른 이메일을 입력해주세요."
                emailWarningLabel.isHidden = false
                emailBool = false
                isButtonOn()
            }
            else{
                emailTextView.layer.borderWidth = 0
                emailWarningLabel.isHidden = true
                emailBool = true
                isButtonOn()
            }
        case passwordTextField:
            let regList: [String] = ["^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}", "^(?=.*[A-Za-z])(?=.*[0-9]).{8,16}", "^(?=.*[A-Za-z])(?=.*[!@#$%^&*()_+=-]).{8,16}", "^(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"]
            var regiBoolList: [Bool] = []
            var regiCount = 0
            regiBoolList = isValidPassword(testStr: passwordTextField.text ?? "", regEx: regList)
            for valid in regiBoolList{
                if valid {
                    regiCount += 1
                }
            }
            print(regiBoolList)
            if regiCount < 1{
                passwordTextView.layer.borderWidth = 1
                passwordTextView.layer.borderColor = UIColor.red.cgColor
                passwordWarningLabel.text = "영문, 숫자, 특수문자 중 2가지 이상을 사용해주세요."
                passwordWarningLabel.isHidden = false
                pwdBool = false
                isButtonOn()
            }
            else{
                passwordTextView.layer.borderWidth = 0
                passwordWarningLabel.isHidden = true
                pwdBool = true
                isButtonOn()
            }
        case confirmTextField:
            if confirmTextField.text != passwordTextField.text {
                confirmTextView.layer.borderWidth = 1
                confirmTextView.layer.borderColor = UIColor.red.cgColor
                confirmWarningLabel.isHidden = false
                confirmWarningLabel.text = "비밀번호가 일치하지 않아요."
                pwdCheckBool = false
                isButtonOn()
            }
            else{
                confirmTextView.layer.borderWidth = 0
                confirmWarningLabel.isHidden = true
                pwdCheckBool = true
                isButtonOn()
            }
        default:
            print("default")
        }
   
    }
    @objc func textFieldDidChange(_ sender: Any?) {
        if passwordTextField.text?.count ?? 0 > 1{
            if passwordTextField.text?.count ?? 0 < 8 {
                passwordTextView.layer.borderWidth = 1
                passwordTextView.layer.borderColor = UIColor.red.cgColor
                passwordWarningLabel.isHidden = false
                passwordWarningLabel.text = "8자 이상의 비밀번호를 입력해주세요."
            }
            else {
                passwordTextView.layer.borderWidth = 0
                passwordWarningLabel.isHidden = true
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        case passwordTextField, confirmTextField:
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if isBackSpace == -92 {
                    return true
                }
            }
            guard textField.text!.count < 16 else { return false }
        default:
            return true
            
        }
        return true
    }
}


