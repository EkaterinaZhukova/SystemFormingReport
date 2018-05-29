//
//  AddNewUserViewController.swift
//  PrPs
//
//  Created by Ekaterina on 29.05.18.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData

class AddNewUserViewController: UIViewController {

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var isAdminSwitch: UISwitch!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func addNewUserInDB(login:String, password:String,isAdmin:Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(login, forKey: "login")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(isAdmin, forKey: "isAdmin")
        do {
            try context.save()
            print("Saved")
            let alertController = UIAlertController(title: "Успех!", message:
                "Новый пользователь был добавлен в БД", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)

        } catch {
            print("Failed saving")
        }

    }
    @IBAction func addNewUser(_ sender: Any) {
        var login:String?=loginTF?.text
        var password:String?=passwordTF?.text
        if(login != nil && password != nil && login != "" && password != ""){
            var isAdminInt:Int
            if(isAdminSwitch.isOn){
                isAdminInt=1
            }
            else{
                isAdminInt=0
            }
            addNewUserInDB(login: login!, password: password!, isAdmin: isAdminInt)
        }
        else{
            let alertController = UIAlertController(title: "Некорректные данные", message:
                "Проверьте логин и/или пароль", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
