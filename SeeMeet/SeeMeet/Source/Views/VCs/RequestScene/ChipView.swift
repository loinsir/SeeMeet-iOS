//
//  ChipView.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/15.
//

import UIKit
import Then
import SnapKit

class ChipView: UIView {
    
    var name: String = ""
    
    private let searchedLabel = UILabel().then{
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
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            configUI()
            setLayout()
        }
        
        private func configUI() {
            backgroundColor = UIColor.pink01
            layer.cornerRadius = 13
            searchedLabel.text = name
        
        }
        
        private func setLayout() {
            addSubviews([searchedLabel,removeButton])
            
            
            self.snp.makeConstraints({
                $0.width.equalTo(82)
                $0.height.equalTo(26)
            })
            
            removeButton.snp.makeConstraints{
                $0.trailing.equalToSuperview().offset(11)
                $0.centerY.equalToSuperview()
            }
            
            searchedLabel.snp.makeConstraints{
                $0.leading.equalToSuperview().offset(13)
                $0.centerY.equalToSuperview()
            }
           
        }
    func setName(name: String){
        searchedLabel.text = name
    }

}
