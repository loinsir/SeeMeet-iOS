//
//  ScheduleTVC.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/17.
//
import UIKit

class ScheduleTVC: UITableViewCell {
    static let identifier: String = "ScheduleTVC"
    var time: String = "09 - 11"
    var plansTitle: String = "마라샹궈"
    
    
    private let dotView = UIView().then{
        $0.backgroundColor = UIColor.pink01
        
    }
    private let plansTimeLabel = UILabel().then{
        $0.textColor = UIColor.grey06
        $0.font = UIFont.dinProMediumFont(ofSize: 18)
    }
    private let separateLineView = UIView().then{
        $0.backgroundColor = UIColor.grey04
    }
    private let plansTitleLabel = UILabel().then{
        $0.font = UIFont.hanSansMediumFont(ofSize: 16)
        $0.textColor = UIColor.grey05
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        setLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    private func addContentView(){
        addSubviews([dotView,plansTimeLabel,separateLineView,plansTitleLabel])
    }
    
    func setLayout(){
        dotView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(5)
        }
        plansTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(dotView.snp.trailing).offset(21)
            $0.centerY.equalToSuperview()
        }
        separateLineView.snp.makeConstraints{
            $0.leading.equalTo(plansTimeLabel.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(19)
        }
        plansTitleLabel.snp.makeConstraints{
            $0.leading.equalTo(separateLineView.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
        }
        
        backgroundColor = UIColor.grey01
        
       
        dotView.layer.cornerRadius = 5/2
      
        

    }
    func setData(time: String,plansTitle: String){
        plansTimeLabel.text = time
        plansTitleLabel.text = plansTitle
    }

}
