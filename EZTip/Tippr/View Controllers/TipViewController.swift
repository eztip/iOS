//
//  TipViewController.swift
//  EZTip
//
//  Created by Cameron Dunn on 2/5/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tipLabel : UILabel!
    @IBOutlet weak var workerEntry: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    var tipAmount : String = ""
    var workerSelected = Worker()
    let numbersArray : [String] = ["1","2","3","4","5","6","7","8","9","0"]
    var refinedArray : [WorkerWithImage] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(refinedArray.count > 0 && !(workerEntry.text?.isEmpty)!){
            return refinedArray.count
        }else{
        return controller.workersWithImages.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WorkerTableViewCell
        if(refinedArray.count > 0 && !(workerEntry.text?.isEmpty)!){
            cell.worker = refinedArray[indexPath.row].worker ?? Worker()
            cell.nameLabel.text = refinedArray[indexPath.row].worker?.username
            cell.bioLabel.text = refinedArray[indexPath.row].worker?.tagline
            cell.profileImage.image = UIImage(data: refinedArray[indexPath.row].imageData)
        }else{
            cell.worker = controller.workersWithImages[indexPath.row].worker ?? Worker()
            cell.nameLabel.text = controller.workersWithImages[indexPath.row].worker?.username
            cell.bioLabel.text = controller.workersWithImages[indexPath.row].worker?.tagline
            cell.profileImage.image = UIImage(data: controller.workersWithImages[indexPath.row].imageData)
        }
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.isHidden = false
        closeButton.isHidden = false
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        refineList()
        tableView.reloadData()
        tableView.reloadSections(IndexSet(), with: UITableView.RowAnimation.fade)
        tableView.isHidden = false
        closeButton.isHidden = false
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        workerEntry.resignFirstResponder()
        return true
    }
    
    
    func refineList(){
        refinedArray.removeAll()
        if(!(workerEntry.text?.isEmpty)!){
            for x in controller.workersWithImages{
                if (x.worker?.username.lowercased().contains(workerEntry.text!.lowercased()))!{
                    refinedArray.append(x)
                }
            }
        }
    }
    
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        closeButton.isHidden = true
        tableView.isHidden = true
        workerEntry.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(refinedArray.count > 0){
            workerSelected = refinedArray[indexPath.row].worker!
        }else{
            workerSelected = controller.workersWithImages[indexPath.row].worker!
        }
        workerEntry.resignFirstResponder()
        tableView.isHidden = true
        workerEntry.text = "\(workerSelected.username)"
        closeButton.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workerEntry.delegate = self
        tableView.rowHeight = 100
        controller.fetchWorkers(token: loggedInToken!) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func oneTapped(_ sender: Any) {
        updateTips(numberToAdd: "1")
    }
    
    
    @IBAction func twoTapped(_ sender: Any) {
        updateTips(numberToAdd: "2")
    }
    
    
    @IBAction func threeTapped(_ sender: Any) {
        updateTips(numberToAdd: "3")
    }
    
    
    @IBAction func fourTapped(_ sender: Any) {
        updateTips(numberToAdd: "4")
    }
    
    
    @IBAction func fiveTapped(_ sender: Any) {
        updateTips(numberToAdd: "5")
    }
    
    
    @IBAction func sixTapped(_ sender: Any) {
        updateTips(numberToAdd: "6")
    }
    
    
    @IBAction func sevenTapped(_ sender: Any) {
        updateTips(numberToAdd: "7")
    }
    
    
    @IBAction func eightTapped(_ sender: Any) {
        updateTips(numberToAdd: "8")
    }
    
    
    @IBAction func nineTapped(_ sender: Any) {
        updateTips(numberToAdd: "9")
    }
    
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        tipAmount = ""
        tipLabel.text = "$\(tipAmount)"
        clearButton.isHidden = true
    }
    
    
    @IBAction func decimalTapped(_ sender: Any) {
        if(tipAmount.contains(".")){
            let alert = UIAlertController(title: "Error", message: "Tips may only contain one decimal.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
            updateTips(numberToAdd: ".")
        }
    }
    @IBAction func zeroTapped(_ sender: Any) {
        if(tipAmount == ""){
            let alert = UIAlertController(title: "Error", message: "Tips may not start with a 0", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
            updateTips(numberToAdd: "0")
        }
    }
    
    func updateTips(numberToAdd number: String){
        for x in numbersArray{
            for y in numbersArray{
                if(tipAmount.contains(".\(x)\(y)")){
                    let alert = UIAlertController(title: "Error", message: "Tips many only have two characters after the decimal point", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    present(alert, animated: true)
                    return
                }
            }
        }
            clearButton.isHidden = false
            tipAmount.append(number)
            tipLabel.text = "$\(tipAmount)"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
    @objc func refresh(){
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SendingTipDetailViewController
        destination.tipToSend = tipAmount
        destination.worker = workerSelected
    }
}
