//
//  ViewController.swift
//  HitList
//
//  Created by Abul Kashem on 29/1/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    var people : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let menagedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do{
            people = try menagedContext.fetch(fetchRequest)
        }catch let err as NSError{
            print("Could Not Fetch \(err) , \(err.userInfo)")
        }
        
    }
    
    
    @IBAction func barButtonAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name", message: "Add a New Name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text else{
                return
            }
            
            self.save(name: nameToSave)
            self.listTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func save(name: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let menagedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: menagedContext)!
        let person = NSManagedObject(entity: entity, insertInto: menagedContext)
        person.setValue(name, forKeyPath: "name")
        
        do{
            try menagedContext.save()
            people.append(person)
        }catch let err as NSError{
            print("Could Not Save \(err) , \(err.userInfo)")
        }
        
        
    }
    
    
    func setUpTableView(){
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: "ListTableViewCell")
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        let person = people[indexPath.row]
        cell.nameListLabel.text = person.value(forKeyPath: "name") as? String
        return cell
    }
    
    
}
