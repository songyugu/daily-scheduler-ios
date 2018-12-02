//
//  Event.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//



import Foundation
import UIKit

struct EventResponse: Codable {
    var data: Event
}


struct EventDataResponse: Codable {
    var eventz: Event
}


class Event: Codable {
    var id: Int
    var title: String
    var detail: String
    var location: String
    var importance: String
    
    init(id: Int, title: String, detail: String, location: String, importance: String) {
        self.id = id
        self.title = title
        self.detail = detail
        self.location = location
        self.importance = importance
    }
    
}
