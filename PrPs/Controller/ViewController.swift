//
//  ViewController.swift
//  PrPs
//
//  Created by Ekaterina on 26.05.18.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    var data=[Users]()

    @IBOutlet weak var loginTF: UITextField!

    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        data = try! context.fetch(fetchRequest) as! [Users]
        print(data.count)
        for dt in data{
            print("\(dt.login) \(dt.password)")
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func enterButton(_ sender: Any) {
        var login=loginTF?.text
        var password=passwordTF?.text

        for dt in data{
            if(dt.login==login && dt.password==password){
                if(dt.isAdmin==0){
                UserDefaults.standard.set(false, forKey: "isAdmin")
                }
                else{
                    UserDefaults.standard.set(true, forKey: "isAdmin")
                }
                performSegue(withIdentifier: "goToMainMenu", sender: nil)
            }
            else{

            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

