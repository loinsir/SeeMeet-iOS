//
//  ChipView.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/15.
//

import UIKit
import Then
import SnapKit

protocol TapRemoveButtonDelegate{
    func tapRemoveButton(chipView: ChipView)
}

class ChipView: UIView {
    
    var friendsData = FriendsData()
    var tapRemoveButtonDelegate: TapRemoveButtonDelegate?
    
    private let nameLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.white
    }
    
    private let removeButton = UIButton().then{
        $0.setImage(UIImage(named: "property1White"), for: .normal)
    }

    override init(frame: CGRect) {
            super.init(frame: frame)
            configUI()
            setLayout()
            setGestureRecognizer()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            configUI()
            setLayout()
            setGestureRecognizer()
        }
        
        private func configUI() {
            backgroundColor = UIColor.pink01
            layer.cornerRadius = 13
            nameLabel.text = self.friendsData.username
        
        }
        
        private func setLayout() {
            addSubviews([nameLabel,removeButton])
            
            
            self.snp.makeConstraints({
                $0.width.equalTo(82)
                $0.height.equalTo(26)
            })
            
            removeButton.snp.makeConstraints{
                $0.trailing.equalToSuperview().offset(11)
                $0.centerY.equalToSuperview()
            }
            
            nameLabel.snp.makeConstraints{
                $0.leading.equalToSuperview().offset(13)
                $0.centerY.equalToSuperview()
            }
           
        }
    func setFriendsData(friendsData: FriendsData){
        self.friendsData = friendsData
        self.nameLabel.text = friendsData.username
    }
    
    func setGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapButton(gestureRecognizer:)))
        removeButton.addGestureRecognizer(tapRecognizer)
        removeButton.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        
    }
    
    @objc func tapButton(gestureRecognizer: UIGestureRecognizer){
        tapRemoveButtonDelegate?.tapRemoveButton(chipView: self)
    }

}
