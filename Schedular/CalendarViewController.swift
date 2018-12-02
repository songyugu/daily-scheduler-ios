//
//  CalendarViewController.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//

import UIKit


struct Colors {
    static var darkGray = UIColor.darkGray
    static var darkRed = UIColor.darkText
}

protocol CalendarDelegate: class {
    
}

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegate
{
 
  
  
 
    weak var delegate: CalendarDelegate?

    var numOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0
    

//    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
//
     

//        login(email: "hi@abc.com", password: "password")
        
    }
    

    
    
//    func login(email: String, password: String) {
//        NetworkManager.login(email: email, password: password) { (user) in
//            print("User with token \(user.token) logged in!")
//        }
//    }
//
//    
 
//
    let monthView: MonthView = {
        let a = MonthView()
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    
    let weekdayView: WeekdaysView = {
        let a = WeekdaysView()
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //myCollectionView.register(UICollectionView.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.backgroundColor = UIColor.clear
        myCollectionView.allowsMultipleSelection = false
        return myCollectionView
    }()
    
    func initializeView() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth=getFirstWeekDay()
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
   

        view.addSubview(weekdayView)
        view.addSubview(monthView)
        view.addSubview(myCollectionView)
      
        setupConstraints()
        myCollectionView.delegate=self
        myCollectionView.dataSource = self
        myCollectionView.register(dataCVCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dataCVCell
        cell.backgroundColor = UIColor.clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden = true
        } else {
            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden = false
            cell.lbl.text = "\(calcDate)"
            if calcDate < todaysDate && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                cell.isUserInteractionEnabled = false
                cell.lbl.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled = true
                cell.lbl.textColor = UIColor.black
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = Colors.darkRed
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = UIColor.white
        // push event vc code
        
        let vc = EventViewController()
        vc.year = currentYear
        vc.month = currentMonthIndex
        vc.day = todaysDate
        vc.delegate = self as? EventDelegate
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = UIColor.black
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let hght: CGFloat = 40
        return CGSize(width : width, height: hght)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day == 2 ? 7 : day
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        firstWeekDayOfMonth = getFirstWeekDay()
        myCollectionView.reloadData()
        monthView.btnLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
    
    func setupConstraints() {
        monthView.delegate=self
        NSLayoutConstraint.activate([
            monthView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            monthView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            monthView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthView.heightAnchor.constraint(equalToConstant: 35)
            ])
        NSLayoutConstraint.activate([
            weekdayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekdayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekdayView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
            weekdayView.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myCollectionView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
       
        
        
        //        addSubview(monthView)
        //        monthView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        //        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        //        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        //        monthView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        //        monthView.delegate = self
        //
        //        addSubview(weekdayView)
        //        weekdayView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
        //        weekdayView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        //        weekdayView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        //        weekdayView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        //        addSubview(myCollectionView)
        //        myCollectionView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor, constant: 0).isActive = true
        //        myCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        //        myCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        //        myCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

class dataCVCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(lbl)
        lbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lbl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lbl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    let lbl: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font=UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Date: Codable {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
