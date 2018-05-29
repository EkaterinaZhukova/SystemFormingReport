//
//  AddNewOrderViewController.swift
//  PrPs
//
//  Created by Ekaterina on 29.05.18.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData

class AddNewOrderViewController: UIViewController, UITableViewDataSource {
    var arrGoods = [Goods]()
    var index:Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        createDataPicker()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Goods", in: context)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goods")
        arrGoods = try! context.fetch(fetchRequest) as! [Goods]
        self.tableView.isHidden=true

        // Do any additional setup after loading the view.
    }
    @IBAction func chooseGood(_ sender: Any) {
        if(tableView.isHidden){
            tableView.isHidden=false
        }
        else{
            index = tableView.indexPathForSelectedRow?.row
            tableView.isHidden=true
            }
        }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "good")! as UITableViewCell
        cell.textLabel?.text=arrGoods[indexPath.row].name!
        cell.detailTextLabel?.text="\(arrGoods[indexPath.row].cost) + бел. руб."
        return cell
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var clintNameTF: UITextField!
    let datePicker=UIDatePicker()
    var orderDate:Date?=nil


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func add(_ sender: Any) {


    }
    @objc func donePressed(){
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        orderDate=datePicker.date
        dateTF.text="\(datePicker.date)"
        self.view.endEditing(true)
    }
    func addDataToDB(clientName:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Orders", in: context)

        let order = Orders(context: context)
        order.date=orderDate
        order.client=clientName
        order.good=arrGoods[index!]
        do {
            try context.save()
            print("Saved")
            let alertController = UIAlertController(title: "Успех!", message:
                "Новый заказ был добавлен в БД", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)

        } catch {
            print("Failed saving")
        }
    }
    @IBAction func addNewOrderButton(_ sender: Any) {
        let clientName:String?=clintNameTF.text

        if(clientName==nil || clientName=="" || index==nil || orderDate==nil){
            let alertController = UIAlertController(title: "Ошибка!", message:
                "Проверьте введенные данные", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            addDataToDB(clientName: clientName!)
        }

    }
    func createDataPicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTF.inputAccessoryView=toolbar
        dateTF.inputView=datePicker
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
