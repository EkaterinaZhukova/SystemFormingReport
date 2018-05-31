//
//  ReportOnClientViewController.swift
//  PrPs
//
//  Created by fpmi on 30.05.2018.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData


class ReportOnClientViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource {
    let dateFormatter = DateFormatter()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "clientsOnGood")! as UITableViewCell
        cell.textLabel?.text=resultArr[indexPath.row].client!
        cell.detailTextLabel?.text=dateFormatter.string(from: resultArr[indexPath.row].date!)
        return cell
    }
    
    
    var arrGoods = [Goods]()
    var arrOrders = [Orders]()
    var resultArr = [Orders]()
    var index:Int?=nil
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrGoods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrGoods[row].name!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        goodTF.text=arrGoods[row].name
        index=row
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goodTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat="YYYY-MM-dd"
        let pickerView = UIPickerView()
        pickerView.delegate = self
        goodTF.inputView = pickerView

        
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
    
    
    
    @IBAction func showClients(_ sender: Any) {
        resultArr.removeAll()
        if(index == nil){
            let alertController = UIAlertController(title: "Ошибка!", message:
                "Выберите товар для формирвоания запроса", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let goodToCompare = arrGoods[index!]
            print(index!)
            print(arrGoods[index!].name)
            for ord in arrOrders{
                if(ord.good == goodToCompare){
                    resultArr.append(ord)
                    print(ord.client)
                    print(ord.good)
                    print(resultArr.count)
                }
            }
        }
        tableView.reloadData()
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
