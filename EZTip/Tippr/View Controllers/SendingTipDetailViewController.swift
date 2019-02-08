//
//  SendingTipDetailViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/5/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class SendingTipDetailViewController: UIViewController {
    let controller = Controller()
    var tipToSend : String?
    var worker : Worker?
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        if(tipToSend == ""){
            confirmButton.isHidden = true
            headerLabel.text = "Uh-oh."
            tipLabel.text = "You did not enter a tip, please return to the previous screen to enter a tip."
            return
        }
        tipLabel.text = "You are about to send a tip to \(worker?.username ?? "Unknown") for $\(tipToSend ?? "0.00")."
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        guard let tipInt = Float(tipToSend!) else {return}
        guard let newWorker = worker else {return}
        let tip = Tip(workerID: newWorker.id, tipAmount: tipInt)
        controller.addTip(tip: tip, token: loggedInToken!) { (error) in
            print("Successfully sent tip")
            self.navigationController?.popToRootViewController(animated: true)
        }
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
