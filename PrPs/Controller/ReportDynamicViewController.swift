//
//  ReportDynamicViewController.swift
//  PrPs
//
//  Created by fpmi on 30.05.2018.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData

class ReportDynamicViewController: UIViewController, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starDatetTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    let datePicker = UIDatePicker()
    var startDate:Date?
    var endDate:Date?
    var arrOrders = [Orders]()
    var resultArr = [Orders]()
    let dateFormatter=DateFormatter()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "dynamic")! as UITableViewCell
        cell.textLabel?.text="\(resultArr[indexPath.row].client!) \(dateFormatter.string(from: resultArr[indexPath.row].date!))"
        cell.detailTextLabel?.text="\((resultArr[indexPath.row].good?.name!)!)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        createStartDataPicker()
        createEndDataPicker()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Orders", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
            arrOrders = try! context.fetch(fetchRequest) as! [Orders]
    }
    @objc func startPresed(tf:UITextField){
       
        startDate=datePicker.date
        starDatetTF.text = dateFormatter.string(from: startDate!)
        self.view.endEditing(true)
    }
    @objc func endPressed(tf:UITextField){
        
        endDate=datePicker.date
        endDateTF.text = dateFormatter.string(from: endDate!)
        self.view.endEditing(true)
    }
    func createStartDataPicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(startPresed))
        toolbar.setItems([doneButton], animated: false)
        starDatetTF.inputAccessoryView=toolbar
        starDatetTF.inputView=datePicker
    }
    func createEndDataPicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(endPressed))
        toolbar.setItems([doneButton], animated: false)
        endDateTF.inputAccessoryView=toolbar
        endDateTF.inputView=datePicker
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showButton(_ sender: Any) {
        resultArr.removeAll()
        if(startDate == nil || endDate == nil){
            let alertController = UIAlertController(title: "Ошибка!", message:
                "Проверьте ввели ли вы все данные", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            for or in arrOrders{
                if(or.date! <= endDate! && or.date! >= startDate!){
                    resultArr.append(or)
                }
            }
        }
        tableView.reloadData()
    }
}
