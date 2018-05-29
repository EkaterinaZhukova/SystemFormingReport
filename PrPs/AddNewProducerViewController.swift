//
//  AddNewProducerViewController.swift
//  PrPs
//
//  Created by Ekaterina on 29.05.18.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData

class AddNewProducerViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!

    func addDataToDB(name:String, phoneNumber:String, email:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Producers", in: context)
        let newProducer = NSManagedObject(entity: entity!, insertInto: context)
        newProducer.setValue(name, forKey: "name")
        newProducer.setValue(phoneNumber, forKey: "phoneNumber")
        newProducer.setValue(email, forKey: "email")
        do {
            try context.save()
            print("Saved")
            let alertController = UIAlertController(title: "Успех!", message:
                "Новый производитель был добавлен в БД", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)

        } catch {
            print("Failed saving")
        }
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        let entity=NSEntityDescription.entity(forEntityName: "Producer", in: context)
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName:"Producers")

        var producers=[Producers]()
        producers = try! context.fetch(fetchRequest) as! [Producers]

        print(producers.count)
        for pr in producers{
            print("\(pr.name) - \(pr.phoneNumber)")
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func addNewProducer(_ sender: Any) {
        var name:String?=nameTF?.text
        var phoneNumber:String?=phoneNumberTF?.text
        var email:String?=emailTF?.text

        if(name==nil || phoneNumber==nil || email==nil || name=="" || phoneNumber=="" || email==""){
            let alertController = UIAlertController(title: "Некорректные данные", message:
                "Проверьте введенные данные", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            addDataToDB(name:name!,phoneNumber:phoneNumber!,email:email!)
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
