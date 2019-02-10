//
//  Model.swift
//  Tippr
//
//  Created by Cameron Dunn on 2/7/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation
import UIKit

var loggedInToken : Token?

class Controller{
    
    
    
    var tips : [TipResponse] = []
    var tipsWithSender : [TipWithSender] = []
    var currentWorker : Worker?
    var workers : [Worker]?
    var workersWithImages : [WorkerWithImage] = []
    var wasError : Bool = false
    
    let baseURL : URL = URL(string: "https://eztip.herokuapp.com/")!
    
    func fetchImages(completion: @escaping (Error?) -> Void){
        guard let safeWorkers = workers else {return}
        for x in safeWorkers{
            var data : Data?
            do{
                data = try Data(contentsOf: URL(string: x.profilePhoto)!)
            }catch{
                print(error)
            }
            guard let safeData = data else {continue}
            var newWorker = WorkerWithImage(imageData: safeData as Data)
            newWorker.worker = x
            workersWithImages.append(newWorker)
        }
        completion(nil)
    }
    
    func registerUser(user: User, completion: @escaping (Error?, Token?) -> Void){
        let url = baseURL.appendingPathComponent("register")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do{
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(user)
        }catch{
            print(error)
            completion(error, nil)
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error{
                print(error)
                completion(error, nil)
                return
            }
            if let data = data{
                do{
                    let response = try JSONDecoder().decode(Token.self ,from: data)
                    loggedInToken = response
                }catch{
                    print(error)
                }
            }
            completion(nil, loggedInToken)
        }.resume()
    }
    
    
    func loginUser(username: String, password: String, completion: @escaping (Error?, Token?) -> Void){
        let url = baseURL.appendingPathComponent("login")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let postString = ["username": username, "password": password]
        
        do{
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(postString)
        }catch{
            print(error)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error{
                print(error)
                
                completion(error, nil)
                return
            }
            if let data = data{
                self.wasError = false
                do{
                  loggedInToken = try JSONDecoder().decode(Token.self, from: data)
                }catch{
                print(error)
                self.wasError = true
                }
            }
            completion(nil, loggedInToken)
        }.resume()
    }
    
    
    func addTip(tip: Tip, token : Token, completion: @escaping (Error?) -> Void){
        //Add who is sending the tip.
        let url = baseURL.appendingPathComponent("tips")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(token.token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        do{
           let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(tip)
        }catch{
            print(error)
            completion(error)
            return
        }
        completion(nil)
    }
    
    
    func getTips(token: Token, completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathComponent("tips")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue(token.token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error{
                print(error)
                completion(error)
                return
            }
            if let data = data{
                do{
                    let response = try JSONDecoder().decode([TipResponse].self, from: data)
                    self.tips = response
                }catch{
                    print(error)
                }
            }
            self.getWorkerInfo(token: token, completion: completion)
        }.resume()
        
    }
    
    func getWorkerInfo(token: Token, completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathComponent("workers/\(currentWorker?.id ?? 1)")
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            urlRequest.addValue(token.token, forHTTPHeaderField: "Authorization")
            var tipWithSender = TipWithSender(worker: WorkerWithImage(imageData: Data()))
            URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                if let error = error{
                    print(error)
                    completion(error)
                    return
                }
                if let data = data{
                    do{
                        let response = try JSONDecoder().decode(Worker.self, from: data)
                        tipWithSender.sender.worker = response
                    }catch{
                        print(error)
                    }
                    var imageData : Data?
                    do{
                        if(tipWithSender.sender.worker != nil){
                            imageData = try Data(contentsOf: URL(string: (tipWithSender.sender.worker!.profilePhoto))!)
                        }
                    }catch{
                        print(error)
                    }
                    if(imageData != nil){
                        tipWithSender.sender.imageData = imageData!
                    }
                    self.tipsWithSender.append(tipWithSender)
                }
                completion(nil)
            }.resume()
    }
    
    
    func fetchWorkers(token: Token, completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathComponent("workers")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue(token.token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error{
                print(error)
                completion(error)
                return
            }
            if let data = data{
                do{
                    let response = try JSONDecoder().decode([Worker].self, from: data)
                    self.workers = response
                }catch{
                    print(error)
                }
            }
            self.findCurrentWorker()
            self.fetchImages(completion: completion)
        }.resume()
    }
    func findCurrentWorker(){
        for x in workers!{
            if(x.username == loggedInToken?.username){
                currentWorker = x
            }
        }
    }
    
    
}
