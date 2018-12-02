//
//  AddEventViewController.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//


import UIKit

class AddEventViewController: UIViewController {
    
    var titleName: UITextField!
    var detailName: UITextField!
    var locationName: UITextField!
    var importanceName: UITextField!
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    var locationLabel: UILabel!
    var importanceLabel: UILabel!
    var saveButton: UIButton!
    
    weak var delegate: AddEventViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleName = UITextField()
        titleName.translatesAutoresizingMaskIntoConstraints = false
        titleName.backgroundColor = .lightGray
        titleName.textColor = .white
        view.addSubview(titleName)
        
        detailName = UITextField()
        detailName.translatesAutoresizingMaskIntoConstraints = false
        detailName.backgroundColor = .lightGray
        detailName.textColor = .white
        view.addSubview(detailName)
        
        locationName = UITextField()
        locationName.translatesAutoresizingMaskIntoConstraints = false
        locationName.backgroundColor = .lightGray
        locationName.textColor = .white
        view.addSubview(locationName)
        
        importanceName = UITextField()
        importanceName.translatesAutoresizingMaskIntoConstraints = false
        importanceName.backgroundColor = .lightGray
        importanceName.textColor = .white
        view.addSubview(importanceName)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Event Title:"
        view.addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = "Detail:"
        view.addSubview(detailLabel)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "Location:"
        view.addSubview(locationLabel)
        
        importanceLabel = UILabel()
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.text = "How Important:"
        view.addSubview(importanceLabel)
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .lightGray
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("Save and Add", for: .normal)
        saveButton.addTarget(self, action: #selector(dismissViewControllerAndSaveText), for: .touchUpInside)
        view.addSubview(saveButton)
        
        
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalToConstant: 120)
            ])
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            detailLabel.widthAnchor.constraint(equalToConstant: 120)
            ])
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            locationLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 30),
            locationLabel.widthAnchor.constraint(equalToConstant: 120)
            ])
        NSLayoutConstraint.activate([
            importanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            importanceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30),
            importanceLabel.widthAnchor.constraint(equalToConstant: 120)
            ])
        NSLayoutConstraint.activate([
            titleName.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            titleName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            titleName.widthAnchor.constraint(equalToConstant: 180)
            ])
        NSLayoutConstraint.activate([
            detailName.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor, constant: 20),
            detailName.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 30),
            detailName.widthAnchor.constraint(equalToConstant: 180)
            ])
        NSLayoutConstraint.activate([
            locationName.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 20),
            locationName.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 30),
            locationName.widthAnchor.constraint(equalToConstant: 180)
            ])
        NSLayoutConstraint.activate([
            importanceName.leadingAnchor.constraint(equalTo: importanceLabel.trailingAnchor, constant: 20),
            importanceName.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 30),
            importanceName.widthAnchor.constraint(equalToConstant: 180)
            ])
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: importanceLabel.trailingAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            saveButton.widthAnchor.constraint(equalToConstant: 180)
            ])
    }
    
    @objc func dismissViewControllerAndSaveText() {
        let text1 = titleName.text
        let text2 = detailName.text
        let text3 = locationName.text
        let text4 = importanceName.text
        //Int(text4)
        if let actualText1 = text1, actualText1 != ""{
            if let actualText2 = text2, actualText2 != ""{
                if let actualText3 = text3, actualText3 != ""{
                    if let actualText4 = text4, actualText4 != ""{
                        NetworkManager.createAnEvent(title: actualText1, detail: actualText2, location: actualText3, importance: actualText4) { (event) in
                            self.delegate?.addAEvent(AddedEvent: event)
                        }
                        
                    }
                }
            }
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
