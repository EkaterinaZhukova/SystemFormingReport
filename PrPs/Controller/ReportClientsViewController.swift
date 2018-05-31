//
//  ReportClientsViewController.swift
//  PrPs
//
//  Created by Ekaterina on 29.05.18.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData

class ReportClientsViewController: UIViewController, UITableViewDataSource {

    struct output{
        var client:String
        var goodName:String
        init(clientNameStr:String, goodNameStr:String){
            client=clientNameStr
            goodName=goodNameStr
        }
    }
    var arrGoods = [Goods]()
    var arrOrders = [Orders]()

    var resultArr = [output]()

    @IBOutlet weak var dateTF: UITextField!
    let datePicker=UIDatePicker()
    var orderDate:Date?=nil
    @IBOutlet weak var tableView: UITableView!
    func createDataPicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTF.inputAccessoryView=toolbar
        dateTF.inputView=datePicker
    }
    @objc func donePressed(){
        resultArr.removeAll()
        tableView.reloadData()
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        orderDate=datePicker.date
        dateTF.text=dateFormatter.string(from: orderDate!)
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let comps = gregorian.components([.year, .month, .day], from: orderDate!)
        for ord in arrOrders{
            let cmp = gregorian.components([.year, .month, .day], from: ord.date!)
            if(cmp==comps){
                let op = output(clientNameStr: ord.client!,goodNameStr: (ord.good?.name!)!)
                resultArr.append(op)
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: resultArr.count-1, section: 0)], with: .automatic)
                tableView.endUpdates()
            }
        }

        self.view.endEditing(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "reportClient")! as UITableViewCell
        cell.textLabel?.text=resultArr[indexPath.row].client
        cell.detailTextLabel?.text="\(resultArr[indexPath.row].goodName)"
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataPicker()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Goods", in: context)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goods")
        arrGoods = try! context.fetch(fetchRequest) as! [Goods]

        let entityOrder = NSEntityDescription.entity(forEntityName: "Orders", in: context)

        let fetchRequestOrder = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
        arrOrders = try! context.fetch(fetchRequestOrder) as! [Orders]


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
