//
//  NetWorkmanager.swift
//  Schedular
//
//  Created by Songyu Gu on 12/1/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {

    static func dateString(year: Int, month: Int, day: Int)-> String {
        let month_str = month < 10 ? "0\(month)" : "\(month)"
        let day_str = day < 10 ? "0\(day)" : "\(day)"
        
        return "\(year)-\(month_str)-\(day_str)"
    }
    
    private static let eventEndpoint = "http://35.196.11.54/api/events"
    private static let postcreateAnEventEndpoint = "http://35.196.11.54/api/events/"
    private static let postEndpoint = "http://35.196.11.54/api/events"


    static func getEvent(year: Int, month: Int, day: Int, completion: @escaping ([Event]) -> Void) {

        let headers: HTTPHeaders = [
            "Authorization": "Bearer {idToken}"
        ]


        Alamofire.request("\(eventEndpoint)/\(dateString(year: year, month: month, day: day))", method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }

                let jsonDecoder = JSONDecoder()

                if let eventResponse = try? jsonDecoder.decode(EventResponse.self, from: data) {
                    completion([eventResponse.data])
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    static func createAnEvent(title: String, detail: String, location: String, importance: String, completion: @escaping (Event) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer {idToken}"
        ]
        
        let parameters = [
            "title" : title,
            "detail" : detail,
            "location" : location,
            "importance" : importance
        ]
        
        Alamofire.request(postcreateAnEventEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let eve = try? jsonDecoder.decode(Event.self, from: data) {
                    completion(eve)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func setEvent(NewEvent: Event, completion: @escaping (Event) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer {idToken}"
        ]
        
        let parameters = [
            "title" : NewEvent.title,
            "detail" : NewEvent.detail,
            "location" : NewEvent.location,
            "importance" : NewEvent.importance
        ]
        
        Alamofire.request("\(postEndpoint)/\(NewEvent.id)", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                
                let jsonDecoder = JSONDecoder()
                
                if let eventResponse = try? jsonDecoder.decode(EventResponse.self, from: data) {
                    completion(eventResponse.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    
    
}
