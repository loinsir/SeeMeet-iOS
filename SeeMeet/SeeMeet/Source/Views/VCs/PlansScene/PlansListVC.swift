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
        $0.text = "완료되었어요."
        $0.textColor = UIColor.grey06
    }
    private let progressHeadCountLabel = UILabel()
    private let completeHeadCountLabel = UILabel()
    //collectionScrollView
    private let collectionScrollView = UIScrollView().then{
        $0.isPagingEnabled = true
        $0.bounces = false
        $0.backgroundColor = .none
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    //progressCollectionView
    private var progressCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .none
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    //completeCollectionView
    private var completeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .none
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
//MARK: Var
    static let identifier: String = "PlansListVC"
    
    var progressPlansCount: Int = 0
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight() - 88
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
        
        progressCollectionView.registerCustomXib(xibName: "ProgressReceiveCVC")
        completeCollectionView.registerCustomXib(xibName: "ProgressReceiveCVC")
                
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
            $0.height.equalTo(90)
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
            $0.height.equalTo(90)
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
//MARK: Server
}

//MARK: Extension
extension PlansListVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: userWidth - 40, height: 144.0)
    }
}
extension PlansListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: ProgressReceiveCVC.identifier, for: indexPath) as! ProgressReceiveCVC
        return cell
    }
    
    
}
extension PlansListVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}
