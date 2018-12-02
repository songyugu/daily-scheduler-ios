//
//  EventViewController.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//



import UIKit

protocol DetailViewControllerDelegate: class {
    func didChangeEvent(NewEvent: Event, row: Int)
}

protocol  AddEventViewControllerDelegate: class {
    func addAEvent(AddedEvent: Event)
}

protocol EventDelegate: class {
    func viewEvent(year: Int, month: Int, day: Int)
}

class EventViewController: UIViewController {
    
    weak var delegate: EventDelegate?
    
    var month: Int = 0
    var day: Int = 0
    var year: Int = 0
    
    // Note: change to Date object
    var tableView: UITableView!
    var events: [Event]!
    var addEvents: UIBarButtonItem!
    
    let reuseIdentifier = "EventCellReuse"
    let cellHeight: CGFloat = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        view.backgroundColor = .white
        
//        NetworkManager.getEvent(year: year, month: month, day: day) { events in
//            events = events
//            self.tableView.reloadData()
//        }
        // let model: CalendarEvent
        
        //class CaledarEvents {
        //var events: [Int: [Int : [Int: [Event]]]]
        // var monthIcons:
        // }
        //        let model: [Int: [Int : [Int: [Event]]]]
        
        events = []
        
        //model[year]![month]![day]!.append(Event())
        // model[year][month][day].sort()
        // Initialize tableView
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self as! UITableViewDelegate
        tableView.dataSource = self as! UITableViewDataSource
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addEventViewController))

        setupConstraints()
        getEvent()
    }
//
    func getEvent() {
        NetworkManager.getEvent(year: year, month: month, day: day) {eventsArray in
            self.events = eventsArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate methods
extension EventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    //Mark: delete cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let Event = events[indexPath.row]
        detailVC.delegate = self
        detailVC.event = Event
        detailVC.row = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    

    
    @objc func addEventViewController() {
        let addEventViewController = AddEventViewController()
        addEventViewController.delegate = self
        present(addEventViewController, animated: true, completion: nil)
    }
    
}





// MARK: - tableViewDataSource
extension EventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EventTableViewCell
        let Event = events[indexPath.row]
        cell.configure(for: Event)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        
        return cell
    }
}

extension EventViewController: DetailViewControllerDelegate {
//    func didChangeEvent(NewEvent: Event, row: Int) {
//        events[row] = NewEvent
//    }
    
    func didChangeEvent(NewEvent: Event, row: Int) {
        events[row] = NewEvent
        NetworkManager.setEvent(NewEvent: NewEvent) { (event) in
           
        }
        self.tableView.reloadData()
        
        
    }
    
}

extension EventViewController: AddEventViewControllerDelegate {
    func addAEvent(AddedEvent: Event) {
        events.append(AddedEvent)
        tableView.reloadData()
    }
}

extension EventViewController: EventDelegate {
    func viewEvent(year: Int, month: Int, day: Int) {
        
        tableView.reloadData()
    }
}
