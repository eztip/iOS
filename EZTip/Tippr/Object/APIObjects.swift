//
//  Worker.swift
//  Tippr
//
//  Created by Cameron Dunn on 2/7/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation

struct WorkerWithImage: Codable{
    var worker : Worker?
    var imageData : Data
    
    init(imageData : Data){
        worker = nil
        self.imageData = imageData
    }
}
struct Worker : Codable{
    var id : Int
    var tagline : String
    var profilePhoto : String
    var workingSince : String
    var username : String
    var firstName : String
    var lastName : String
    var occupation : String
    var userType : String
    
    init(){
        id = Int()
        tagline = String()
        profilePhoto = String()
        workingSince = String()
        username = String()
        firstName = String()
        lastName = String()
        occupation = String()
        userType = String()
    }
    enum CodingKeys : String, CodingKey{
        case username, occupation, id, tagline
        case firstName = "first_name"
        case lastName = "last_name"
        case userType = "user_type"
        case workingSince = "working_since"
        case profilePhoto = "profile_photo"
    }
}

struct Tip : Codable{
    var workerID : Int
    var tipAmount : Float
    
    enum CodingKeys : String, CodingKey{
        case workerID = "worker_id"
        case tipAmount = "tip_amount"
    }
    init(workerID: Int, tipAmount : Float){
        self.workerID = workerID
        self.tipAmount = tipAmount
    }
}

struct TipWithSender: Codable{
    var tip : TipResponse?
    var sender : WorkerWithImage
    init(worker : WorkerWithImage){
        self.sender = WorkerWithImage(imageData: Data())
    }
}

struct TipResponse : Codable{
    var id : Int
    var workerID : Int
    var tipDate : String
    var tipAmount : Float
    
    enum CodingKeys : String, CodingKey{
        case id
        case workerID = "worker_id"
        case tipDate = "tip_date"
        case tipAmount = "tip_amount"
    }
    init(workerID: Int, tipDate: String, tipAmount: Float){
        id = Int()
        self.workerID = workerID
        self.tipDate = tipDate
        self.tipAmount = tipAmount
    }
}

struct User : Codable{
    var username : String
    var password : String
    
    init(name: String, pass: String){
        username = name
        password = pass
    }
}
struct Token : Codable{
    var userId : Int
    var username : String
    var userType : String
    var token : String
    
    enum CodingKeys : String, CodingKey{
        case userId, username, token
        case userType = "user_type"
    }
}

