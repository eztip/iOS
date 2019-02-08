//
//  RecentTipsViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/5/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class RecentTipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let controller = Controller()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(controller.tipsWithSender.count)
        return controller.tipsWithSender.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TipTableViewCell
        cell.nameLabel.text = controller.tipsWithSender[indexPath.row].sender.worker?.username
        cell.tipLabel.text = "\(controller.tipsWithSender[indexPath.row].tip?.tipAmount ?? 0)"
        cell.profileImage.image = UIImage(data: controller.tipsWithSender[indexPath.row].sender.imageData)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = loggedInToken?.username else {
            welcomeLabel.text = "Welcome to Tippr"
            return
        }
        welcomeLabel.text = "Welcome, \(username)"
        controller.getTips(token: loggedInToken!) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if(self.controller.tipsWithSender.count == 0){
                    self.smallLabel.text = "You currently haven't recieved any tips."
                    self.tableView.isHidden = true
                }else{
                    self.tableView.isHidden = false
                    self.smallLabel.text = "Here's a list of your recent tips:"
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
