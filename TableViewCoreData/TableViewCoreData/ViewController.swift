//
//  ViewController.swift
//  TableViewCoreData
//
//  Created by Abul Kashem on 7/2/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var country: UITextField!
    var cName = [Countryname]()
    //var name: Countryname?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        let dh = DatabaseHandler()
        cName = dh.fetchData()
        tableView.reloadData()
    }

    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        let dialogMessage = UIAlertController(title: "Add Data", message: "Enter Country Name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){ (action) in
            let newCountryName = self.country.text!
            let dh = DatabaseHandler()
            dh.saveData(cName: newCountryName)
            self.cName = dh.fetchData()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){(action) in
            print("Cancel the operation")
        }
        
        dialogMessage.addAction(okAction)
        dialogMessage.addAction(cancelAction)
        dialogMessage.addTextField{(textField) in
            self.country = textField
            self.country.placeholder = "Type County Name"
        }
        
        self.present(dialogMessage, animated: true,completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel?.text = cName[indexPath.row].countryname
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete{

            let newCountryName = cName[indexPath.row]
            let dh = DatabaseHandler()
            dh.deleteToData(identifer: newCountryName)
            self.cName = dh.fetchData()
            self.tableView.reloadData()
        }
        
    }
    
}


