//
//  HomeEventCVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/08.
//

import UIKit
import SnapKit
import Then

class HomeEventCVC: UICollectionViewCell {
    
    static let identifier: String = "HomeEventCVC"
    
//MARK: Componnents

    private let dDayView = UIView().then{
        $0.backgroundColor = UIColor.pink01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18
    }
    private let dDayLabel = UILabel().then{
        $0.font = UIFont.dinProBoldFont(ofSize: 24)
        $0.textColor = UIColor.white
        $0.textAlignment = .center
    }
    private let eventImageView = UIImageView().then{
        $0.image = UIImage(named: "Ellipse_dummy")
    }
    private let eventNameLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .center
    }
    private let eventDateLabel = UILabel().then{
        $0.font = UIFont.hanSansRegularFont(ofSize: 14)
        $0.textColor = UIColor.grey06
        $0.textAlignment = .center
    }
//MARK: Layout
    func setBackgroundViewLayout() {
        self.getShadowView(color: UIColor.black.withAlphaComponent(0.25).cgColor, masksToBounds: true, shadowOffset: CGSize(width: 2, height: 4), shadowRadius: 10, shadowOpacity: 0.25)
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 18
    }
    func setLayout() {
        addSubviews([dDayView, eventImageView, eventNameLabel, eventDateLabel])
        dDayView.addSubview(dDayLabel)
        
        dDayView.snp.makeConstraints{
            $0.top.equalTo(11)
            $0.width.equalTo(53)
            $0.height.equalTo(29)
            $0.centerX.equalToSuperview()
            
        }
        dDayLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        eventImageView.snp.makeConstraints{
            $0.top.equalTo(9)
            $0.width.height.equalTo(82)
            $0.centerX.equalToSuperview()
        }
        eventNameLabel.snp.makeConstraints{
            $0.top.equalTo(eventImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().offset(19)
            $0.height.equalTo(18)
        }
        eventDateLabel.snp.makeConstraints{
            $0.top.equalTo(eventDateLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(52)
            $0.height.equalTo(18)
        }
        
    }
    
//MARK: Function
    
    func setData(dDay: String, image: String, eventName: String, eventData: String){
        dDayLabel.text = dDay
        eventImageView.image = UIImage(named: image)
        eventNameLabel.text = eventName
        eventDateLabel.text = eventData
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundViewLayout()
        setLayout()
        // Initialization code
    }

}
