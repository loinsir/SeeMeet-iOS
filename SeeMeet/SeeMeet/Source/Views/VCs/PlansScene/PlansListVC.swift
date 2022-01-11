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
        $0.text = "진행중이에요."
        $0.textColor = UIColor.grey06
    }
    private let completeHeadLabel = UILabel().then{
        $0.text = "완료되었어요."
        $0.textColor = UIColor.grey06
    }
    private let progressHeadCountLabel = UILabel()
    private let completeHeadCountLabel = UILabel()
    //collectionScrollView
    private let collectionScrollView = UIScrollView().then{
        //$0.tag = 1
        $0.isPagingEnabled = true
        $0.bounces = false
        //$0.contentSize.width = UIScreen.main.bounds.width
        //$0.contentSize = CGSize(width: UIScreen.main.bounds.width*2, height:   - (userHeigth * 0.27 + 151))
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
    }
//MARK: Layout
    func setHeaderLayout() {
        view.addSubview(plansListBackgroundView)
        plansListBackgroundView.addSubview(headerView)
        headerView.addSubviews([backButton, headerLabel, progressView, completeView, bottomView])
        progressView.addSubview(progressLabel)
        completeView.addSubview(completeLabel)
        
        
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
    func setFontCollectionHeader() {
        
    }
//MARK: Function
    
//MARK: Server
}

//MARK: Extension

