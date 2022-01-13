//
//  SMSearchBar.swift
//  SeeMeet
//
//  Created by 김인환 on 2022/01/13.
//

import UIKit
import SnapKit

class SMSearchBar: UISearchBar {
    
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
        setImage(UIImage(named: "ic_search"), for: .search, state: .normal)
        setImage(UIImage(named: "btn_remove"), for: .clear, state: .normal)
        backgroundColor = UIColor.grey01
        backgroundImage = UIImage()
        searchBarStyle = .minimal
        isTranslucent = false
        layer.cornerRadius = 10
    }
    
    private func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }

}
