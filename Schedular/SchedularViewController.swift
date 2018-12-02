//
//  SchedulerViewController.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//

import UIKit

class SchedularViewController: UIViewController {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let t:UITouch! = touch
            let touchPoint = t.location(in: self.view)
            eventView = UIView(frame: CGRect(x: touchPoint.x, y: touchPoint.y, width: 100, height: 100))
            eventView.backgroundColor = UIColor.gray
            
            view.addSubview(eventView)
        }
    }
    
    var eventView: UIView!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Schedular" ////
        label.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(label)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 120)
            ])
    }
    
    
    
}
