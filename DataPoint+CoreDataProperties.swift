//
//  DataPoint+CoreDataProperties.swift
//  Budget
//
//  Created by Daniel Madjar on 1/4/24.
//
//

import Foundation
import CoreData


extension DataPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataPoint> {
        return NSFetchRequest<DataPoint>(entityName: "DataPoint")
    }

    @NSManaged public var balance: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var fund: FundEntity?

}

extension DataPoint : Identifiable {

}
