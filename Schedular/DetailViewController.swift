//
//  DetailViewController.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//



import UIKit

class DetailViewController: UIViewController {
    
    var event: Event!
    var row : Int!
    
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    var locationLabel: UILabel!
    var importanceLabel: UILabel!
    
    var titleName: UITextField!
    var detailName: UITextField!
    var locationName: UITextField!
    var importanceName: UITextField!
    
    var saveButton: UIBarButtonItem!
    
    let labelHeight: CGFloat = 30
    let labelWidth: CGFloat = 150
    
    
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.text = "Event Title:"
        view.addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = .black
        detailLabel.text = "Detail:"
        view.addSubview(detailLabel)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .black
        locationLabel.text = "Location:"
        view.addSubview(locationLabel)
        
        importanceLabel = UILabel()
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.font = UIFont.systemFont(ofSize: 14)
        importanceLabel.textColor = .black
        importanceLabel.text = "Importance Rate:"
        view.addSubview(importanceLabel)
        
        titleName = UITextField()
        titleName.translatesAutoresizingMaskIntoConstraints = false
        titleName.font = UIFont.systemFont(ofSize: 20)
        titleName.textColor = .black
        titleName.textAlignment = .center
        titleName.backgroundColor = .lightGray
        titleName.text = event.title
        view.addSubview(titleName)
        
        detailName = UITextField()
        detailName.translatesAutoresizingMaskIntoConstraints = false
        detailName.font = UIFont.systemFont(ofSize: 14)
        detailName.textColor = .black
        detailName.textAlignment = .center
        detailName.backgroundColor = .lightGray
        detailName.text = event.detail
        view.addSubview(detailName)
        
        locationName = UITextField()
        locationName.translatesAutoresizingMaskIntoConstraints = false
        locationName.font = UIFont.systemFont(ofSize: 14)
        locationName.textAlignment = .center
        locationName.textColor = .black
        locationName.backgroundColor = .lightGray
        locationName.text = event.location
        view.addSubview(locationName)
        
        importanceName = UITextField()
        importanceName.translatesAutoresizingMaskIntoConstraints = false
        importanceName.font = UIFont.systemFont(ofSize: 14)
        importanceName.textAlignment = .center
        importanceName.textColor = .black
        importanceName.backgroundColor = .lightGray
        importanceName.text = event.importance
        view.addSubview(importanceName)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(dismissViewControllerAndSaveText))
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            detailLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            locationLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 30),
            locationLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            importanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            importanceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30),
            importanceLabel.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        NSLayoutConstraint.activate([
            titleName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            titleName.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 30),
            titleName.heightAnchor.constraint(equalToConstant: labelHeight),
            titleName.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            detailName.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 30),
            detailName.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor, constant: 30),
            detailName.heightAnchor.constraint(equalToConstant: labelHeight),
            detailName.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            locationName.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant:20),
            locationName.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 30),
            locationName.heightAnchor.constraint(equalToConstant: labelHeight),
            locationName.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            importanceName.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 20),
            importanceName.leadingAnchor.constraint(equalTo: importanceLabel.trailingAnchor, constant: 30),
            importanceName.heightAnchor.constraint(equalToConstant: labelHeight),
            importanceName.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
    @objc func dismissViewControllerAndSaveText() {
        let text1 = titleName.text
        let text2 = detailName.text
        let text3 = locationName.text
        let text4 = importanceName.text
        if let actualText1 = text1, actualText1 != ""{
            if let actualText2 = text2, actualText2 != ""{
                if let actualText3 = text3, actualText3 != ""{
                    if let actualText4 = text4, actualText4 != ""{
                        NetworkManager.setEvent(NewEvent: Event(id: event.id, title: actualText1, detail: actualText2, location: actualText3, importance: actualText4)) { (event) in
                            self.delegate?.didChangeEvent(NewEvent: event, row: self.row)
                        }
               
                    }
                }
            }
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
