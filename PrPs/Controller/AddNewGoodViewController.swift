//
//  AddNewGoodViewController.swift
//  PrPs
//
//  Created by Ekaterina on 29.05.18.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData

class AddNewGoodViewController: UIViewController, UITableViewDataSource {

    var arrProducers=[Producers]()
    var index:Int? = nil
    @IBOutlet weak var goodNameTF: UITextField!

    @IBOutlet weak var goodCostTF: UITextField!

    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducers.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "producer")! as UITableViewCell
        cell.textLabel?.text=arrProducers[indexPath.row].name!
        cell.detailTextLabel?.text="\(arrProducers[indexPath.row].email!) - \(arrProducers[indexPath.row].phoneNumber!)"
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Producers", in: context)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Producers")
        arrProducers = try! context.fetch(fetchRequest) as! [Producers]
        self.tableView.isHidden=true
        // Do any additional setup after loading the view.
    }

    @IBAction func showProducersList(_ sender: Any) {
	        if(tableView.isHidden){
            tableView.isHidden=false
        }
            else{
                index=tableView.indexPathForSelectedRow!.row
                tableView.isHidden=true
            }
        }
    func addGoodToDB(name:String,cost:Double,index:Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Goods", in: context)
        let entityProducer=NSEntityDescription.entity(forEntityName: "Producers", in: context)

        let good=Goods(context: context)
        good.producer = arrProducers[index]
        good.name = name
        good.cost = cost
        do {
            try context.save()
            print("Saved")
            let alertController = UIAlertController(title: "Успех!", message:
                "Новый товар был добавлен в БД", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            goodCostTF.text=""
            goodNameTF.text=""
            

        } catch {
            print("Failed saving")
        }
    }
    @IBAction func addNewGood(_ sender: Any) {
        var name:String?=goodNameTF?.text
        var cost:Double?
        cost=try Double(goodCostTF.text!)
        if(cost==nil || name==nil || name==""){
            let alertController = UIAlertController(title: "Ошибка!", message:
                "Проверьте поля", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if(index == nil){
            let alertController = UIAlertController(title: "Ошибка!", message:
                "Выберите производителя", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            addGoodToDB(name: name!, cost: cost!, index: index!)
        }
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
