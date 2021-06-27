//
//  CarEntity+CoreDataProperties.swift
//  final_proj
//
//  Created by pruthvi raj dudam on 3/20/21.
//
//

import Foundation
import CoreData


extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }
    

    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var picture: NSData?

}


extension CarEntity : Identifiable {

}
