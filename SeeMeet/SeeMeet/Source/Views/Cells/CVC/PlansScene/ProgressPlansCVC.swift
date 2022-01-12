//
//  ProgressPlansCVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/12.
//

import UIKit

class ProgressPlansCVC: UICollectionViewCell {
    
    //Property
    private let cellHeadLabel = UILabel().then{
        $0.font = UIFont.hanSansBoldFont(ofSize: 18)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.text = "받은 요청"
    }
    private let newPostNoti = UIView().then{
        $0.backgroundColor = UIColor.pink01
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
    }
    private let receiveLabel = UILabel().then{
        $0.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
