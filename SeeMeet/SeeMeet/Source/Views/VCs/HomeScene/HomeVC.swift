import UIKit
import SnapKit
import Then

class HomeVC: UIViewController {
//MARK: Components
    private let homeBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.grey01
    }
    private let topView = UIView().then{
        $0.backgroundColor = UIColor.pink01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        $0.getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 4), shadowRadius: 3, shadowOpacity: 0.25)
    }
    private let menuButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_menu"), for: .normal)
    }
    private let friendsButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btn_friends"), for: .normal)
    }
    private let profileButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "profile_Dummy"), for: .normal)
    }
    private let dDayLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 22)
        $0.textColor = UIColor.black
        $0.numberOfLines = 2
        //가운데 일수는 26/bold/white
    }
    private let characterImageView = UIImageView().then{
        $0.image = UIImage(named: "Image_dummy")
    }
    private let collectionViewHeadLabel = UILabel().then{
        $0.text = "다가오는 약속"
        $0.font = UIFont.hanSansBoldFont(ofSize: 20)
        $0.textColor = UIColor.black
    }
    private var eventsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .none
        collectionView.bounces = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

//MARK: Var
    var lastEventCont: Int = 0
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight()
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setHomeLayout()
        setCollectionViewLayout()
        changeDdayLabel()
    }
//MARK: Layout
    func setHomeLayout() {
        view.addSubview(homeBackgroundView)
        homeBackgroundView.addSubviews([topView, collectionViewHeadLabel])
        topView.addSubviews([menuButton, friendsButton, profileButton, dDayLabel, characterImageView])
        
        homeBackgroundView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview().offset(0)
        }
        topView.snp.makeConstraints{
            let topViewRatio: CGFloat = 0.6
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(userHeight * topViewRatio)
        }
        menuButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(7)
            $0.height.width.equalTo(48)
        }
        profileButton.snp.makeConstraints{
            $0.centerY.equalTo(menuButton)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(48)
        }
        friendsButton.snp.makeConstraints{
            $0.centerY.equalTo(menuButton)
            $0.trailing.equalTo(profileButton.snp.leading).offset(0)
            $0.width.height.equalTo(48)
        }
        dDayLabel.snp.makeConstraints{
            $0.top.equalTo(menuButton.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(250)
            $0.height.equalTo(63)
        }
        characterImageView.snp.makeConstraints{
            $0.top.equalTo(dDayLabel.snp.bottom).offset(33)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(229)
            $0.height.equalTo(152)
        }
        collectionViewHeadLabel.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(116)
            $0.height.equalTo(32)
        }
    }
    func setCollectionViewLayout(){
        homeBackgroundView.addSubview(eventsCollectionView)
        
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        
        eventsCollectionView.registerCustomXib(xibName: "HomeEventCVC")
        
        eventsCollectionView.snp.makeConstraints{
            let collectionViewRatio: CGFloat = 0.32
            $0.top.equalTo(collectionViewHeadLabel.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(userHeight * collectionViewRatio)
        }
        
    }
//MARK: Function
    func changeDdayLabel() {
        dDayLabel.text = "약속을 잡은지\n벌써 \(lastEventCont)일이 지났어요!"
        guard let text: String = dDayLabel.text else {return}
        let dDayText = NSMutableAttributedString(string: text)
        dDayText.addAttribute(.font, value: UIFont.hanSansBoldFont(ofSize: 26), range: (text as NSString).range(of: "\(lastEventCont)일"))
        dDayText.addAttribute(.foregroundColor, value: UIColor.white, range: (text as NSString).range(of: "\(lastEventCont)일"))
        dDayLabel.attributedText = dDayText
    }
//MARK: Server
}

//MARK: Extension
extension HomeVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = userHeight * 0.3
        let cellWidth = userWidth * 0.4
        
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: HomeEventCVC.identifier, for: indexPath) as! HomeEventCVC
        cell.setData(dDay: "D-15", image: "Ellipse_dummy", eventName: "대방어 데이", eventData: "1월 15일")
        return cell
    }
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}
