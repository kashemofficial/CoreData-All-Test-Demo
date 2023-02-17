//
//  ViewController.swift
//  CoreData SaveDelete
//
//  Created by Abul Kashem on 17/2/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var searchNameTextField: UITextField!
    @IBOutlet weak var searchResultLabel: UILabel!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveUserButton(_ sender: UIButton) {
        if firstNameTextField?.text != " " && secondNameTextField?.text != ""{
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            newUser.setValue(self.firstNameTextField!.text, forKey: "firstName")
            newUser.setValue(self.secondNameTextField!.text, forKey: "secondName")
            do{
                try context.save()
            }catch {
                print(error)
            }
        }else{
            print("please fill the first name and second name")
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let searchString = self.searchNameTextField?.text
        request.predicate = NSPredicate(format: "firstName == %@", searchString!)
        do{
            let result = try context.fetch(request)
            if result.count > 0{
                let firstname = (result[0] as AnyObject).value(forKey: "firstName")as! String
                let secondname = (result[0] as AnyObject).value(forKey: "secondName")as! String
                self.searchResultLabel?.text = firstname + " " + secondname
            }
            else{
                self.searchResultLabel?.text = "No User"
            }
            
        }catch{
            print(error)
        }
        
    }
    
    @IBAction func showAllUserButton(_ sender: UIButton) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "UserViewController")
        navigationController?.pushViewController(VC!, animated: true)
    }

}

