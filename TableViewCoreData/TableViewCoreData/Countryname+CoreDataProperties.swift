//
//  Countryname+CoreDataProperties.swift
//  TableViewCoreData
//
//  Created by Abul Kashem on 10/2/23.
//
//

import Foundation
import CoreData


extension Countryname {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Countryname> {
        return NSFetchRequest<Countryname>(entityName: "Countryname")
    }

    @NSManaged public var countryname: String?

}

extension Countryname : Identifiable {

}
