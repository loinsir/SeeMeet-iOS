import UIKit
import SnapKit
import Then
import CoreMedia

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
        $0.addTarget(self, action: #selector(touchUpFriendsButton(_:)), for: .touchUpInside)
    }
    private let notificationButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "ic_noti"), for: .normal)
        $0.addTarget(self, action: #selector(notiButtonClicked(_:)), for: .touchUpInside)
    }
    private let dDayLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 22)
        $0.textColor = UIColor.black
        $0.numberOfLines = 2
        $0.attributedText = $0.setTextFontColorSpacingAttribute(defaultText: "씨밋과 함께 약속을 잡아볼까요?", value: -0.6, containText: "약속", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
        //가운데 일수는 26/bold/white
    }
    private let characterImageView = UIImageView().then{
        $0.image = UIImage(named: "img_illust_5")
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
    private let noEventImageView = UIImageView().then{
        $0.image = UIImage(named: "img_illust_10")
    }
    private let noEventLabel = UILabel().then{
        $0.text = "일정이 없어요!"
        $0.font = UIFont.hanSansRegularFont(ofSize: 16)
        $0.textColor = UIColor.grey04
        $0.textAlignment = .center
    }

//MARK: Var
    var lastEventCount: String = ""
    var friendsCount: Int = 0
    var userWidth: CGFloat = UIScreen.getDeviceWidth()
    var userHeight: CGFloat = UIScreen.getDeviceHeight() - 88
    
    var homeData: [HomeDataModel] = []
    var friendsData: [FriendsData] = []
    
//MARK: ViewDidLoad
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getFriendsList()
        getHomeData()
        getLastPlansCount()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setHomeLayout()
        setCollectionViewLayout()
        isNoEventLayout()
//        let tk = TokenUtils()
//        tk.delete("accesstoken", account: "accessToken")
        setMainillust()
    }
//MARK: Layout
    func setHomeLayout() {
        self.navigationController?.isNavigationBarHidden = true
        let viewRatio = userHeight / 724
        print(viewRatio)
                        
        view.addSubview(homeBackgroundView)
        homeBackgroundView.addSubviews([topView, collectionViewHeadLabel])
        topView.addSubviews([menuButton, friendsButton, notificationButton, dDayLabel, characterImageView])
        
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
        notificationButton.snp.makeConstraints{
            $0.centerY.equalTo(menuButton)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(48)
        }
        friendsButton.snp.makeConstraints{
            $0.centerY.equalTo(menuButton)
            $0.trailing.equalTo(notificationButton.snp.leading).offset(0)
            $0.width.height.equalTo(48)
        }
        dDayLabel.snp.makeConstraints{
            $0.top.equalTo(menuButton.snp.bottom).offset(35 * viewRatio)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(250)
            $0.height.equalTo(63)
        }
        characterImageView.snp.makeConstraints{
            $0.bottom.equalTo(topView.snp.bottom).offset(-11 * viewRatio)
            $0.trailing.equalToSuperview().offset(-24 * viewRatio)
            $0.width.equalTo(317 * viewRatio)
            $0.height.equalTo(210 * viewRatio)
        }
        collectionViewHeadLabel.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(116)
            $0.height.equalTo(32)
        }
    }
    func setCollectionViewLayout() {
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
    func isNoEventLayout() {
        if homeData.count == 0 {
            homeBackgroundView.addSubviews([noEventImageView, noEventLabel])
            noEventImageView.snp.makeConstraints{
                $0.top.equalTo(collectionViewHeadLabel.snp.bottom).offset(10)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(249)
                $0.height.equalTo(128)
            }
            noEventLabel.snp.makeConstraints{
                $0.top.equalTo(noEventImageView.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(110)
            }
        }
    }
//MARK: Function
    @objc private func notiButtonClicked(_ sender: UIButton){
        guard let plansVC = UIStoryboard(name: "PlansList", bundle: nil).instantiateViewController(withIdentifier: PlansListVC.identifier) as? PlansListVC else {return}
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(plansVC, animated: true)
     }
    
    @objc private func touchUpFriendsButton(_ sender: UIButton) {
        guard let friendsListVC = UIStoryboard(name: "FriendsList", bundle: nil).instantiateViewController(withIdentifier: FriendsListVC.identifier) as? FriendsListVC else { return }
        self.tabBarController?.tabBar.isHidden = true
        friendsListVC.friendsNameData = friendsData.map { $0.username }
        self.navigationController?.pushViewController(friendsListVC, animated: true)
    }
    
    func dateCal(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDate = dateFormatter.date(from: Date.getCurrentYear() + "-" + Date.getCurrentMonth() + "-" + Date.getCurrentDate()) ?? Date()
        let endDate = dateFormatter.date(from: date) ?? Date()

        let interval = endDate.timeIntervalSince(startDate)
        let days = Int(interval / 86400)
        print("\(days) 일 차이 난다") //4일
        
        return String(abs(days))
    }
    func isPrevious(date: String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDate = dateFormatter.date(from: Date.getCurrentYear() + "-" + Date.getCurrentMonth() + "-" + Date.getCurrentDate()) ?? Date()
        let endDate = dateFormatter.date(from: date) ?? Date()

        let interval = endDate.timeIntervalSince(startDate)
        let days = Int(interval / 86400)
        
        if days <= 0 {
            return true
        }
        else {
            return false
        }
        print("\(days) 일 차이 난다")
    }
    func countPrevious(date: String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDate = dateFormatter.date(from: Date.getCurrentYear() + "-" + Date.getCurrentMonth() + "-" + Date.getCurrentDate()) ?? Date()
        let endDate = dateFormatter.date(from: date) ?? Date()

        let interval = endDate.timeIntervalSince(startDate)
        let days = Int(interval / 86400)

        return days
        print("\(days) 일 차이 난다")
    }
    func setDayMonth(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let changeDate = dateFormatter.date(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM-dd"
        let changeDate2 = dateFormatter2.string(from: changeDate ?? Date())
        
        return changeDate2
    }
    func findTodayPlans() -> Bool{
        var i = 0
        for plans in homeData{
//            plans.data[i].date
            if "2022-01-19" == (Date.getCurrentYear() + "-" + Date.getCurrentMonth() + "-" + Date.getCurrentDate()){
                return true
            }
        }
        return false
    }
    func setMainillust(){
        let firstComeIn: String = "씨밋과 함께 약속을 잡아볼까요?"
        let firstFriendAdd: String = "친구가 당신의 약속 신청을 기다리고 있어요!"
        let todayMeet: String = "아싸 오늘은 친구 만나는 날이다!"
        let twoWeek: String = "약속잡기에 딱 좋은 시기에요!"
        let threeWeek: String = "친구와 만난지 벌써 \n\(lastEventCount)일이 지났어요"
        let overThreeWeek: String = "친구를 언제 만났는지 기억도 안나요…"
        
        let randList: [String] = [firstFriendAdd, twoWeek, overThreeWeek]

        if friendsCount == 0 && homeData.count == 0{
            dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: firstComeIn, value: -0.6, containText: "약속", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
            characterImageView.image = UIImage(named: "img_illust_5")
        }
        else if friendsCount > 0 && homeData.count == 0{
            switch randList.randomElement(){
            case firstFriendAdd:
                dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: firstFriendAdd, value: -0.6, containText: "약속 신청", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
                characterImageView.image = UIImage(named: "img_illust_4")
            case twoWeek:
                dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: twoWeek, value: -0.6, containText: "딱 좋은", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
                    characterImageView.image = UIImage(named: "img_illust_8")
            case overThreeWeek:
                dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: overThreeWeek, value: -0.6, containText: "기억도", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
                characterImageView.image = UIImage(named: "img_illust_7")
            default:
                print("error")
            }
        }
        else if isPrevious(date: lastEventCount) {
            if countPrevious(date: lastEventCount) < -14{
                dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: twoWeek, value: -0.6, containText: "딱 좋은", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
                    characterImageView.image = UIImage(named: "img_illust_8")
            }
            else if countPrevious(date: lastEventCount) < -14 && countPrevious(date: lastEventCount) > -21{
                dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: threeWeek, value: -0.6, containText: "딱 좋은", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
                    characterImageView.image = UIImage(named: "img_illust_6")
            }
            else if countPrevious(date: lastEventCount) < -22 {
                dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: threeWeek, value: -0.6, containText: "딱 좋은", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
                    characterImageView.image = UIImage(named: "img_illust_6")
            }
        }
        else if findTodayPlans() {
            dDayLabel.attributedText = dDayLabel.setTextFontColorSpacingAttribute(defaultText: todayMeet, value: -0.6, containText: "친구", changingFont: UIFont.hanSansBoldFont(ofSize: 26), color: UIColor.white)
            characterImageView.image = UIImage(named: "img_illust_1")
        }
    }
//MARK: Server
    func getHomeData(){
        GetHomeDataService.shared.getHomeData(year: Date.getCurrentYear(), month: Date.getCurrentMonth()){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? HomeDataModel{
                           self.homeData.append(response)
                           self.setMainillust()
                           if self.homeData[0].data.count == 0 {
                               self.isNoEventLayout()
                           }
                           else{
                               self.eventsCollectionView.reloadData()
                           }
                       }
                   case .requestErr(let message) :
                       print("requestERR")
                   case .pathErr :
                       print("pathERR")
                   case .serverErr:
                       print("serverERR")
                   case .networkFail:
                       print("networkFail")
                   }
               }
    }
    func getLastPlansCount(){
        GetLastDateService.shared.getLastPlans(year: Date.getCurrentYear(), month: Date.getCurrentMonth(), day: Date.getCurrentDate()){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? LastDateDataModel{
                           self.lastEventCount = self.dateCal(date: response.data.date)
                           print(self.lastEventCount)
                           self.setMainillust()
                       }
                   case .requestErr(let message) :
                       print("requestERR")
                   case .pathErr :
                       print("pathERR")
                   case .serverErr:
                       print("serverERR")
                   case .networkFail:
                       print("networkFail")
                   }
               }
    }
    func getFriendsList(){
        GetFriendsListService.shared.getFriendsList(){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? FriendsDataModel{
                           self.friendsCount = response.data.count
                           self.friendsData = response.data
                       }
                   case .requestErr(let message) :
                       print("requestERR")
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
        if homeData.count == 0{
            return 0
        }
        else {
            if !isPrevious(date: homeData[0].data[section].date){
                return homeData[0].data.count
            }
            else{
                isNoEventLayout()
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: HomeEventCVC.identifier, for: indexPath) as! HomeEventCVC
        let dDayDate = dateCal(date: homeData[0].data[indexPath.row].date)
        let eventDate = homeData[0].data[indexPath.row].date.components(separatedBy: "-")
        let event = eventDate[1] + "-" + eventDate[2]
        var imageName = ""
        
        if Int(homeData[0].data[indexPath.row].count) ?? 0 > 1{
            imageName = "img_illust_3"
        }
        else{
            imageName = "img_illust_2"
        }
        cell.setData(dDay: "D" + dDayDate, image: imageName, eventName: homeData[0].data[indexPath.row].invitationTitle, eventData: event)
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
