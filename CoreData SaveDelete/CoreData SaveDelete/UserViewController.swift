//
//  UserViewController.swift
//  CoreData SaveDelete
//
//  Created by Abul Kashem on 17/2/23.
//

import UIKit

class UserViewController: UIViewController {
    

    @IBOutlet weak var userTableView: UITableView!
    
    var userArray : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTableView.delegate = self
        userTableView.dataSource = self
        
        self.fetchData()
        self.userTableView.reloadData()
        
    }
    
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            userArray = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    
    @IBAction func barButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
extension UserViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let name = userArray[indexPath.row]
        cell.textLabel!.text = name.firstName! + "   " + name.secondName!
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let user = userArray[indexPath.row]
            context.delete(user)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                userArray = try context.fetch(User.fetchRequest())
            }
            catch{
                print(error)
            }
        }
       userTableView.reloadData()
    }
    
}
