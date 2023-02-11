//
//  DatabaseHandler.swift
//  TableViewCoreData
//
//  Created by Abul Kashem on 10/2/23.
//

import Foundation
import CoreData
import UIKit

class DatabaseHandler{
    
    func saveData(cName: String) {
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        let countryObject = NSEntityDescription.insertNewObject(forEntityName: "Countryname", into: context) as! Countryname
        countryObject.countryname = cName
        
        do{
            try context.save()
            print("Data has been saved")
        }catch {
        print("Data has been not save")
        }
        
    }
    
    func deleteToData(identifer: Countryname) {
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        
        do {
            context.delete(identifer)
            try context.save()
            _ = fetchData()
        }
        catch let error as NSError {
           print(error)
        }
        
    }
    
    func fetchData()-> [ Countryname]{
        
        var cName = [Countryname]()
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        
        do{
            cName = try context.fetch(Countryname.fetchRequest()) as! [Countryname]
            
        }catch{
            print("Error Occured During Fetch Request")
        }
        return cName
    }
    
}
