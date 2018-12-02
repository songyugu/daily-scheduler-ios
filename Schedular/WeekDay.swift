//
//  WeekDay.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//


import UIKit

class WeekdaysView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupViews()
    }
    
    
    let myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setupViews() {
        addSubview(myStackView)
        myStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        myStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        var daysArr = ["Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat"]
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i]
            lbl.textAlignment = .center
            lbl.textColor = .black
            myStackView.addArrangedSubview(lbl)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
