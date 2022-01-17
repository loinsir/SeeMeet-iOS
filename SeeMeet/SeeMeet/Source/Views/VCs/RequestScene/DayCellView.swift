//
//  dayCellView.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/17.
//

import UIKit

protocol tapCellViewDelegate{
    func tapCellView(dayCellView: DayCellView )
}
class DayCellView: UIView {
    
    var montosun: String = "월"
    var day: Int = 3
    var isScheduled = Bool()
    
    var tapCellViewDelegate: tapCellViewDelegate?
    
    private let cellView = UIView().then{
        $0.tintColor = UIColor.white
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.white
        
    }
    private let montosunLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 13)
        $0.textColor = UIColor.grey04
        
    }
    
    private let dayLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 13)
        $0.textColor = UIColor.grey06
    }
    private let pinkDot = UIView().then{
        $0.backgroundColor = UIColor.pink01
        $0.layer.cornerRadius = $0.frame.width/2
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
            backgroundColor = UIColor.grey01
            montosunLabel.text = montosun
            dayLabel.text = String(day)
        
        }
        
        private func setLayout() {
            addSubviews([cellView,pinkDot])
            cellView.addSubviews([montosunLabel,dayLabel])
            
            
            self.snp.makeConstraints({
                $0.width.equalTo(42)
                $0.height.equalTo(79)
            })
            
            cellView.snp.makeConstraints{
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(70)
            }
            
            montosunLabel.snp.makeConstraints{
                $0.top.equalToSuperview().offset(13)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().offset(-11)
                
            }
            
            dayLabel.snp.makeConstraints{
                $0.top.equalTo(montosunLabel.snp.bottom).offset(8)
                $0.centerX.equalToSuperview()
            }
            pinkDot.snp.makeConstraints{
                $0.top.equalTo(cellView.snp.bottom).offset(4)
                $0.centerX.equalTo(cellView.snp.centerX)
                $0.width.height.equalTo(5)
            }
           
        }
    func setDate(montosun: String,day: Int,isScheduled: Bool){
        self.montosun = montosun
        self.day = day
        self.montosunLabel.text = montosun
        self.dayLabel.text = String(day)
        self.isScheduled = isScheduled
    }
    
    func setGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCellView(gestureRecognizer:)))
        cellView.addGestureRecognizer(tapRecognizer)
        cellView.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        
    }
    
    @objc func tapCellView(gestureRecognizer: UIGestureRecognizer){
        tapCellViewDelegate?.tapCellView(dayCellView: self)
    }

}
