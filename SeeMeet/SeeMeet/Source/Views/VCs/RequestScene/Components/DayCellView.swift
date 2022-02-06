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
    var isScheduled = Bool() {
        didSet {
            setPinkDotView()
        }
    }
    
    var tapCellViewDelegate: tapCellViewDelegate?
    
    let cellView = UIView().then{
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
    private let pinkDotView = UIView().then{
        $0.backgroundColor = UIColor.pink01
    }
    
    private let touchAreaView: UIView = UIView().then {
        $0.backgroundColor = UIColor.clear
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
            addSubviews([cellView,pinkDotView])
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
            pinkDotView.snp.makeConstraints{
                $0.top.equalTo(cellView.snp.bottom).offset(4)
                $0.centerX.equalTo(cellView.snp.centerX)
                $0.width.height.equalTo(5)
            }
         
            pinkDotView.layer.cornerRadius = 5/2
            pinkDotView.isHidden = true
           
        }
    func setDate(montosun: String,day: Int,isScheduled: Bool){
        self.montosun = montosun
        self.day = day
        self.montosunLabel.text = montosun
        self.dayLabel.text = String(day)
        self.isScheduled = isScheduled
        self.setPinkDotView()
    }
    
    func setDate(day: Int){
        self.day = day
        self.dayLabel.text = String(day)
    }
    func setDate(day:Int, isScheduled: Bool){
        self.isScheduled = isScheduled
        self.setPinkDotView()
    }
    
    func setPinkDotView(){
        if isScheduled == true{
            pinkDotView.isHidden = false
        }else{
            pinkDotView.isHidden = true
        }
    }
    
    func setFillColor(fillColor: UIColor){
        cellView.backgroundColor = fillColor
        
    }
    func setFontColor(fontColor: UIColor){
        montosunLabel.textColor = fontColor
    }
    
    func setTodayState(){
        cellView.layer.borderWidth = 0
        cellView.backgroundColor = UIColor.pink01
        montosunLabel.textColor = .white
        dayLabel.textColor = .white
    }
    
    func setSelectedState(){
        cellView.backgroundColor = UIColor.black
        montosunLabel.textColor = .white
        dayLabel.textColor = .white
    }
    
    func setTodaySelectedState(){
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.layer.borderWidth = 1
        cellView.backgroundColor = UIColor.pink01
        montosunLabel.textColor = .white
        dayLabel.textColor = .white
    }
    func setBasicState() {
        cellView.layer.borderWidth = 0
        cellView.backgroundColor = UIColor.white
        montosunLabel.textColor = .grey04
        dayLabel.textColor = .grey06
    }
    func setInvalidState(){
        cellView.layer.borderWidth = 0
        cellView.backgroundColor = .grey02
        montosunLabel.textColor = .grey03
        dayLabel.textColor = .grey03
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
