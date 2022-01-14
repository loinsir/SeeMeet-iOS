import UIKit
import SnapKit
import Then

class PlansListVC: UIViewController {
//MARK: Components
    //headerView
    private let plansListBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    private let headerView = UIView().then {
        $0.backgroundColor = UIColor.grey01
    }
    private let backButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "btn_back"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked(_:)), for: .touchUpInside)
    }
    private let headerLabel = UILabel().then {
        $0.text = "약속 내역"
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .center
    }
    //customTabbar
    private let progressView = UIView().then {
        $0.backgroundColor = .none
    }
    private let completeView = UIView().then {
        $0.backgroundColor = .none
    }
    private let progressHeadView = UIView().then{
        $0.backgroundColor = .none
    }
    private let completeHeadView = UIView().then{
        $0.backgroundColor = .none
    }
    private let progressLabel = UILabel().then {
        $0.text = "진행중"
        $0.font = UIFont.hanSansBoldFont(ofSize: 16)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .center
    }
    private let completeLabel = UILabel().then {
        $0.text = "완료"
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .center
    }
    private let bottomView = UIView().then{
        $0.backgroundColor = UIColor.grey06
    }
    //collectionViewHeader
    private let progressHeadLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 24)
        let text = $0.setTextFontAttribute(defaultText: "진행 중이에요", containText: "진행 중", changingFont: UIFont.hanSansBoldFont(ofSize: 24), color: UIColor.grey06)
        $0.attributedText = text
    }
    private let completeHeadLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 24)
        let text = $0.setTextFontAttribute(defaultText: "완료되었어요", containText: "완료", changingFont: UIFont.hanSansBoldFont(ofSize: 24), color: UIColor.grey06)
        $0.attributedText = text
        $0.textColor = UIColor.grey06
    }
    private let progressHeadCountLabel = UILabel().then{
        $0.font = UIFont.dinProRegularFont(ofSize: 24)
        $0.textColor = UIColor.grey06
    }
    private let completeHeadCountLabel = UILabel().then{
        $0.font = UIFont.dinProRegularFont(ofSize: 24)
        $0.textColor = UIColor.grey06
    }
    //collectionScrollView
    private let collectionScrollView = UIScrollView().then{
        $0.isPagingEnabled = true
        $0.bounces = false
        $0.backgroundColor = .none
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    //progressCollectionView
    private var progressCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.tag = 1
        $0.setCollectionViewLayout(layout, animated: false)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = .none
        $0.bounces = true
        $0.showsVerticalScrollIndicator = false
    }
    //completeCollectionView
    private var completeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.tag = 2
        $0.setCollectionViewLayout(layout, animated: false)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = .none
        $0.bounces = true
        $0.showsVerticalScrollIndicator = false
    }
//MARK: Var
    static let identifier: String = "PlansListVC"
    
    var progressPlansCount: Int = 0
    var completePlansCount: Int = 0
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight()
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderLayout()
        setScrollViewLayout()
    }
//MARK: Layout
    func setHeaderLayout() {
        view.addSubview(plansListBackgroundView)
        plansListBackgroundView.addSubview(headerView)
        headerView.addSubviews([backButton, headerLabel, progressView, completeView, bottomView])
        progressView.addSubview(progressLabel)
        completeView.addSubview(completeLabel)
        
        let progressTapGesture = UITapGestureRecognizer(target: self, action: #selector(tabbarClicked(_:)))
        let completeTapGesture = UITapGestureRecognizer(target: self, action: #selector(tabbarClicked(_:)))
        progressView.isUserInteractionEnabled = true
        progressView.addGestureRecognizer(progressTapGesture)
        completeView.isUserInteractionEnabled = true
        completeView.addGestureRecognizer(completeTapGesture)

        plansListBackgroundView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview().offset(0)
        }
        headerView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(152)
        }
        backButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.leading.equalToSuperview().offset(2)
            $0.width.height.equalTo(48)
        }
        headerLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
        }
        progressView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.width.equalTo(userWidth * 0.5)
            $0.height.equalTo(50)
        }
        progressLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        completeView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.width.equalTo(userWidth * 0.5)
            $0.height.equalTo(50)
        }
        completeLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        bottomView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.width.equalTo(userWidth * 0.5)
            $0.height.equalTo(3)
        }
        
    }
    func setScrollViewLayout() {
        plansListBackgroundView.addSubview(collectionScrollView)
        collectionScrollView.addSubviews([progressHeadView, completeHeadView, progressCollectionView, completeCollectionView])
        progressHeadView.addSubviews([progressHeadLabel, progressHeadCountLabel])
        completeHeadView.addSubviews([completeHeadLabel, completeHeadCountLabel])
        
        collectionScrollView.delegate = self
        progressCollectionView.delegate = self
        progressCollectionView.dataSource = self
        completeCollectionView.delegate = self
        completeCollectionView.dataSource = self
        
        progressCollectionView.registerCustomXib(xibName: "ProgressSendCVC")
        progressCollectionView.registerCustomXib(xibName: "ProgressReceiveCVC")
        completeCollectionView.registerCustomXib(xibName: "CompletePlansCVC")
                
        collectionScrollView.contentSize = CGSize(width: userWidth * 2, height: userHeight - 152)

        
        collectionScrollView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        progressHeadView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(completeHeadView.snp.leading).offset(0)
            $0.bottom.equalTo(progressCollectionView.snp.top).offset(0)
            $0.height.equalTo(74)
            $0.width.equalTo(userWidth)
        }
        progressHeadLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(145)
        }
        progressHeadCountLabel.snp.makeConstraints{
            $0.centerY.equalTo(progressHeadLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(35)
        }
        completeHeadView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.equalTo(progressHeadView.snp.trailing).offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.bottom.equalTo(completeCollectionView.snp.top)
            $0.height.equalTo(74)
            $0.width.equalTo(userWidth)
        }
        completeHeadLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(145)
        }
        completeHeadCountLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(35)
        }
        progressCollectionView.snp.makeConstraints{
            $0.top.equalTo(progressHeadView.snp.bottom).offset(0)
            $0.bottom.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(completeCollectionView.snp.leading).offset(0)
            $0.width.equalTo(userWidth)
            $0.height.equalTo(userHeight-242)
        }
        completeCollectionView.snp.makeConstraints{
            $0.top.equalTo(completeHeadView.snp.bottom).offset(0)
            $0.bottom.trailing.equalToSuperview().offset(0)
            $0.leading.equalTo(progressCollectionView.snp.trailing).offset(0)
            $0.width.equalTo(userWidth)
            $0.height.equalTo(userHeight-242)
        }
        
        setCountLabel()
        
    }
//MARK: Function
    @objc private func tabbarClicked(_ sender: UIView){
        var contentOffsetX = collectionScrollView.contentOffset.x
        if contentOffsetX >= userWidth{
            collectionScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        else{
            collectionScrollView.setContentOffset(CGPoint(x: userWidth, y: 0), animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveBottomView(offsetX: collectionScrollView.contentOffset.x / 2)
        setTabbarTitle(offsetX: collectionScrollView.contentOffset.x)
        
    }
    func moveBottomView(offsetX: CGFloat){
        bottomView.snp.remakeConstraints{
            $0.leading.equalToSuperview().offset(offsetX)
            $0.height.equalTo(3)
            $0.width.equalTo(userWidth/2)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
    private func setTabbarTitle(offsetX: CGFloat){
        if offsetX > userWidth/2 {
            progressLabel.font = UIFont.hanSansMediumFont(ofSize: 16)
            completeLabel.font = UIFont.hanSansBoldFont(ofSize: 16)
        }
        else{
            progressLabel.font = UIFont.hanSansBoldFont(ofSize: 16)
            completeLabel.font = UIFont.hanSansMediumFont(ofSize: 16)
        }
    }
    private func setCountLabel(){
        progressHeadCountLabel.attributedText = progressHeadCountLabel.setTextFontAttribute(defaultText: "\(progressPlansCount)건", containText: String(progressPlansCount), changingFont: UIFont.dinProBoldFont(ofSize: 24), color: UIColor.pink01)
        completeHeadCountLabel.attributedText = progressHeadCountLabel.setTextFontAttribute(defaultText: "\(completePlansCount)건", containText: String(completePlansCount), changingFont: UIFont.dinProBoldFont(ofSize: 24), color: UIColor.pink01)
    }
    @objc private func backButtonClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
     }
    //MARK: Server
}

//MARK: Extension
extension PlansListVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
            return CGSize(width: userWidth-40, height: 144.0)
        }
        else{
            return CGSize(width: userWidth, height: 146.0)
        }
    }
}
extension PlansListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let progressSendCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressSendCVC.identifier, for: indexPath) as! ProgressSendCVC
            let progressRecieveCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressReceiveCVC.identifier, for: indexPath) as! ProgressReceiveCVC
            return progressRecieveCell
        case 2:
            let completeCell =  collectionView.dequeueReusableCell(withReuseIdentifier: CompletePlansCVC.identifier, for: indexPath) as! CompletePlansCVC
            return completeCell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
extension PlansListVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag{
        case 1:
            return 20
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView.tag {
        case 1:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
