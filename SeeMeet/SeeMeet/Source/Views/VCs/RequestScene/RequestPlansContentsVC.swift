//
//  RequestPlansContentsVC.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/10.
//

import UIKit
import SnapKit
import Then

class RequestPlansContentsVC: UIViewController {
//MARK: Components
    private let titleView = UIView()
    
    private let titleLabel = UILabel().then{
        $0.text = "약속 신청"
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
    }
    
    private let closeButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_close"), for: .normal)
    }
    
    private let friendSelectionLabel = UILabel().then{
        $0.text = "약속 신청할 친구를 선택하세요"
        $0.font = UIFont.hanSansRegularFont(ofSize: 18)
        $0.textColor = UIColor.grey06
        let attributedString = NSMutableAttributedString(string: "약속 신청할 친구를 선택하세요")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.pink01, range: ($0.text! as NSString).range(of:"친구"))
        attributedString.addAttribute(.font, value: UIFont.hanSansBoldFont(ofSize: 18), range: ($0.text! as NSString).range(of: "친구"))
        $0.attributedText = attributedString
        

    }
    /*
    private let searchTextField = UITextField().then{
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.attributedPlaceholder = NSAttributedString(string: "받는 사람:", attributes: [.foregroundColor: UIColor.grey04])
        $0.addLeftPadding(width: 46)
        
    }
     */
    
    private let searchBar = UISearchBar().then{

        $0.placeholder = "받는 사람:"
        $0.setImage(UIImage(named: "ic_search"), for: UISearchBar.Icon.search, state: .normal)
        $0.backgroundColor = UIColor.grey01
        $0.backgroundImage = UIImage()
        $0.searchBarStyle = .minimal
        $0.isTranslucent = false
        $0.layer.cornerRadius = 10
        if let searchBarStyle = $0.value(forKey: "searchField") as? UITextField{
            searchBarStyle.clearButtonMode = .never
        }
       
        if let textfield = $0.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [.foregroundColor: UIColor.grey04, .font: UIFont.hanSansRegularFont(ofSize: 14)])
            textfield.textColor = UIColor.grey06
            textfield.layer.cornerRadius = 10
            textfield.font = UIFont.hanSansRegularFont(ofSize: 14)
 
        }
        
    }
    
   /*
    private let searchImageView = UIImageView().then{
        $0.image = UIImage(named: "ic_search")
        
    }
    */
    
    private let contentsWritingLabel = UILabel().then{
        $0.text = "약속의 내용을 작성하세요"
        $0.font = UIFont.hanSansRegularFont(ofSize: 18)
        $0.textColor = UIColor.grey06
        let attributedString = NSMutableAttributedString(string: "약속의 내용을 작성하세요")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.pink01, range: ($0.text! as NSString).range(of:"내용"))
        attributedString.addAttribute(.font, value: UIFont.hanSansBoldFont(ofSize: 18), range: ($0.text! as NSString).range(of: "내용"))
        $0.attributedText = attributedString
    }
    
    private let plansContentsView = UIView().then{
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
    }
    
    private let plansTitleTextField = UITextField().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [.foregroundColor: UIColor.grey04, .font: UIFont.hanSansRegularFont(ofSize: 14)])
    }
    
    private let seperateLineView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    
    
    
    private let plansContentsTextView = UITextView().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.backgroundColor = UIColor.grey01
        $0.textColor = UIColor.grey06
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.textContainer.lineFragmentPadding = 0
        $0.scrollIndicatorInsets = $0.textContainerInset
    
    }
    
    private let navigationLineView = UIView().then{
        $0.backgroundColor = UIColor.grey02
    }
    
    private let nextButton = UIButton().then{
        $0.backgroundColor = UIColor.grey02
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.text = "메롱"
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.layer.cornerRadius = 10
    }
//MARK: Var
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight()
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setPlaceholder()
        setDelegate()
    }
    
//MARK: Layout
    func setLayout() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubviews([titleView,friendSelectionLabel,searchBar,contentsWritingLabel,plansContentsView,navigationLineView,nextButton])
        titleView.addSubviews([titleLabel,closeButton])

        plansContentsView.addSubviews([plansTitleTextField,seperateLineView,plansContentsTextView])
        
        titleView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(58)
        }
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        closeButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-4)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        friendSelectionLabel.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(32)
        }
        searchBar.snp.makeConstraints{
            $0.top.equalTo(friendSelectionLabel.snp.bottom).offset(7)
            $0.leading.equalTo(friendSelectionLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    
        searchBar.searchTextField.snp.makeConstraints{
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        /*
        searchImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.width.height.equalTo(34)
        }
         */
        contentsWritingLabel.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(38)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(32)
        }
        plansContentsView.snp.makeConstraints{
            $0.top.equalTo(contentsWritingLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(255)
        }
        plansTitleTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(32)
        }
        seperateLineView.snp.makeConstraints{
            $0.top.equalTo(plansTitleTextField.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(1)
        }
        plansContentsTextView.snp.makeConstraints{
            $0.top.equalTo(seperateLineView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().offset(9)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.equalToSuperview().offset(-5)
        }
        navigationLineView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top).offset(-16)
            $0.height.equalTo(1)
        
        }
        nextButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-42)
            $0.height.equalTo(54)
        }
        
    }
    
//MARK: Delegate
    func setDelegate(){
        searchBar.delegate = self
        plansTitleTextField.delegate = self
        plansContentsTextView.delegate = self
    }
   
}

//MARK: Extension
extension RequestPlansContentsVC: UITextViewDelegate{
    func setPlaceholder() {
        plansContentsTextView.text = "약속 상세 내용"
        plansContentsTextView.textColor = UIColor.grey04
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.grey04{
            textView.text = nil
            textView.textColor = UIColor.black
        }/*
        if (!textView.text.isEmpty) && (textView.text != "약속 상세 내용") {
            textView.text = nil
            textView.textColor = UIColor.black
          */
        plansContentsView.layer.borderColor = UIColor.pink01.cgColor
        plansContentsView.layer.borderWidth = 1.0
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "약속 상세 내용"
            textView.textColor = UIColor.grey04
        }
        plansContentsView.layer.borderWidth = 0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let attrString = NSMutableAttributedString(string: textView.text,attributes: [.font: UIFont.hanSansRegularFont(ofSize: 14),.kern: -0.6])
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attrString.length))
        textView.attributedText = attrString
        print(attrString)
            }
 

}

extension RequestPlansContentsVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{/*
        case searchTextField:
            textField.layer.borderColor = UIColor.pink01.cgColor
            textField.layer.borderWidth = 1.0
                          */
        case plansTitleTextField:
            plansContentsView.layer.borderColor = UIColor.pink01.cgColor
            plansContentsView.layer.borderWidth = 1.0
        default:
            textField.layer.borderWidth = 0
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
            /*
        case searchTextField:
            textField.layer.borderWidth = 0
             */
        case plansTitleTextField:
            plansContentsView.layer.borderWidth = 0
        default:
            textField.layer.borderWidth = 0
        }
    }
}

extension RequestPlansContentsVC: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = UIColor.pink01.cgColor
        searchBar.layer.borderWidth = 1.0
       
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderWidth = 0
    }
}
