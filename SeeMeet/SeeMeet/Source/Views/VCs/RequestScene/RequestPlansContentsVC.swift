//
//  RequestPlansContentsVC.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/10.
//

import UIKit
import SnapKit
import Then

class RequestPlansContentsVC: UIViewController,UIGestureRecognizerDelegate {
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

    private let searchTextField = UITextField().then{
        $0.backgroundColor = UIColor.grey01
        $0.layer.cornerRadius = 10
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.attributedPlaceholder = NSAttributedString(string: "받는 사람:", attributes: [.foregroundColor: UIColor.grey04])
        $0.addLeftPadding(width: 46)
    }
    
    private let chipView1 = ChipView()
    private let chipView2 = ChipView()
    private let chipView3 = ChipView()
    
        
   /*
    private let searchedLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.white
    }
    
    private let removeButton = UIButton().then{
        $0.setImage(UIImage(named: "property1White"), for: .normal)
    }
*/
    private let searchTableView: UITableView = {
        let searchTableView = UITableView()
        searchTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.identifier)
        return searchTableView
    }()
    
    private let whiteView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
   /*
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
    */
    
  
    private let searchImageView = UIImageView().then{
        $0.image = UIImage(named: "ic_search")
        
    }

    
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
        $0.titleLabel?.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.layer.cornerRadius = 10
    }
//MARK: Var
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight()
    var nameList: [String] = ["이유진","김인환","박익범","정재용","오수린","유가영","서강덕","이종현","이선빈","김준희","엄희수","남지윤","구건모","손시형","최유림","이동기","이유정","김현아"]
    var filterNameList = [String]()
    var searchedNameList = [String]()
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setPlaceholder()
        setDelegate()
      //  setSearchToken()
        self.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /*
//MARK: Function
    func setSearchToken() {
        let searchToken = UISearchToken(icon: UIImage(systemName: "pencil"), text: "안녕 펜슬")
        searchToken.representedObject = SearchTokenView.self
                searchBar.searchTextField.allowsDeletingTokens = false
    }
    
     */
    func setChipView(){
        searchTextField.placeholder = nil//셀추가시 플레이스 홀더 업애기
               
//        chipView2.snp.makeConstraints{
//            $0.leading.equalTo(chipView1.snp.trailing).offset(11)
//            $0.centerY.equalToSuperview()
//        }
//        chipView3.snp.makeConstraints{
//            $0.leading.equalTo(chipView2.snp.trailing).offset(11)
//            $0.centerY.equalToSuperview()
//        }
        searchTextField.leftView?.addSubview(chipView1)
        searchTextField.leftView?.addSubview(chipView2)
        searchTextField.leftView?.addSubview(chipView3)
        
        
        chipView1.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(44)
            $0.top.equalToSuperview().offset(11)
//            $0.centerY.equalToSuperview() 왜 안먹니 ..
          
        }
        chipView2.snp.makeConstraints{
            $0.leading.equalTo(chipView1.snp.trailing).offset(11)
            $0.top.equalToSuperview().offset(11)
        }
        chipView3.snp.makeConstraints{
            $0.leading.equalTo(chipView2.snp.trailing).offset(11)
            $0.top.equalToSuperview().offset(11)
        }
        
        switch searchedNameList.count{
        case 0:
            chipView1.isHidden = true
            chipView2.isHidden = true
            chipView3.isHidden = true
            searchTextField.setLeftPadding(width: 46+2-5)
        case 1:
            chipView1.isHidden = false
            chipView2.isHidden = true
            chipView3.isHidden = true
            chipView1.setName(name: searchedNameList[0])
            searchTextField.setLeftPadding(width: 46+2+93-5)
            
        case 2:
          
            chipView1.isHidden = false
            chipView2.isHidden = false
            chipView3.isHidden = true
            chipView1.setName(name: searchedNameList[0])
            chipView2.setName(name: searchedNameList[1])
            searchTextField.setLeftPadding(width: 46+2+93+93-5)
           
        case 3:
            
            chipView1.isHidden = false
            chipView2.isHidden = false
            chipView3.isHidden = false
            chipView1.setName(name: searchedNameList[0])
            chipView2.setName(name: searchedNameList[1])
            chipView3.setName(name: searchedNameList[2])
            searchTextField.setLeftPadding(width: 46+2+93+93+93+100-5)
        default:
            chipView1.isHidden = false
            chipView2.isHidden = false
            chipView3.isHidden = false
        }
    }
    
//MARK: Layout
    func setLayout() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubviews([titleView,friendSelectionLabel,searchTextField,contentsWritingLabel,plansContentsView,navigationLineView,nextButton,whiteView,searchTableView])
        titleView.addSubviews([titleLabel,closeButton])
        searchTextField.addSubview(searchImageView)
        
       
      
        
                                    
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

        
        searchTextField.snp.makeConstraints{
            $0.top.equalTo(friendSelectionLabel.snp.bottom).offset(7)
            $0.leading.equalTo(friendSelectionLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
       

        whiteView.snp.makeConstraints{
            $0.top.equalTo(searchTextField.snp.bottom).offset(0)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        searchTableView.snp.makeConstraints{
            $0.top.equalTo(searchTextField.snp.bottom).offset(10)
            $0.leading.equalTo(searchTextField.snp.leading).offset(23)
            $0.trailing.equalTo(searchTextField.snp.trailing).offset(-22)
            $0.height.equalTo(240)
        }
        
        searchImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.width.height.equalTo(34)
        }
         
        contentsWritingLabel.snp.makeConstraints{
            $0.top.equalTo(searchTextField.snp.bottom).offset(38)
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
        
        whiteView.isHidden = true
        searchTableView.isHidden = true
        searchTableView.separatorStyle = .none
        chipView1.isHidden = true
        chipView2.isHidden = true
        chipView3.isHidden = true
        searchTextField.isUserInteractionEnabled = true
//        searchTextField.leftView?.isUserInteractionEnabled = true
        }
    
//MARK: Delegate
    func setDelegate(){
        searchTextField.delegate = self
        plansTitleTextField.delegate = self
        plansContentsTextView.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        chipView1.tapRemoveButtonDelegate = self
        chipView2.tapRemoveButtonDelegate = self
        chipView3.tapRemoveButtonDelegate = self
        
        
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
            }
 

}

extension RequestPlansContentsVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case searchTextField:
            textField.layer.borderColor = UIColor.pink01.cgColor
            textField.layer.borderWidth = 1.0
            whiteView.isHidden = false
            searchTableView.isHidden = false
            filterNameList = nameList
            searchTableView.reloadData()
        case plansTitleTextField:
            plansContentsView.layer.borderColor = UIColor.pink01.cgColor
            plansContentsView.layer.borderWidth = 1.0
           
        default:
            textField.layer.borderWidth = 0
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case searchTextField:
            textField.layer.borderWidth = 0
            whiteView.isHidden = true
        case plansTitleTextField:
            plansContentsView.layer.borderWidth = 0
        default:
            textField.layer.borderWidth = 0
        }
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if searchTextField.text == ""{
            filterNameList = nameList
            searchTableView.reloadData()
            
        }else {
            whiteView.isHidden = false
            searchTableView.isHidden = false
            filterNameList = nameList.filter { $0.lowercased().prefix(searchTextField.text!.count) == searchTextField.text!.lowercased() }
           
            searchTableView.reloadData()
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchTableView.isHidden = true
        return true
    }
    
    
}

/*
extension RequestPlansContentsVC: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderColor = UIColor.pink01.cgColor
        searchBar.layer.borderWidth = 1.0
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.layer.borderWidth = 0
        searchTableView.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.searchTextField.text == ""{
            searchTableView.isHidden = true
            
        }else {
            searchTableView.isHidden = false
            filterNameList = nameList.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
            searchTableView.snp.updateConstraints{ make in
                make.height.equalTo(50*filterNameList.count)
            }//테이블 높이 동적 변경인데 뒤에 흰뷰 박아버리면 필요 없을 듯요 ..
           
            searchTableView.reloadData()
        }

    }
}
 */

extension RequestPlansContentsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.identifier,for: indexPath) as? SearchTVC else {return UITableViewCell()}
        cell.setData(name: filterNameList[indexPath.row])
        
        return cell
    }
    
    
}

extension RequestPlansContentsVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // searchBar.searchTextField.tokens.append(UISearchToken(icon: UIImage(), text: "hello"))
       
        searchTextField.text = ""//이름 선택하면 텍스트 필드 비우기
        if(searchedNameList.count<3){ //이름 세개까지만 추가
            searchedNameList.append(filterNameList[indexPath.row])
            setChipView()
            print(searchedNameList)
        }
        
    }
}

extension RequestPlansContentsVC: TapRemoveButtonDelegate{
    
    func tapRemoveButton(chipView: ChipView) {
        print("tapped")
        let name: String
        name = chipView.name
        if let idx = searchedNameList.firstIndex(of: name){
            searchedNameList.remove(at: idx)
        }
        print(searchedNameList)
        setChipView()
    }
    
}


