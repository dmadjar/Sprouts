//
//  FundItem+CoreDataProperties.swift
//  Budget
//
//  Created by Daniel Madjar on 1/4/24.
//
//

import Foundation
import CoreData


extension FundItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FundItem> {
        return NSFetchRequest<FundItem>(entityName: "FundItem")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var fund: FundEntity?

}

extension FundItem : Identifiable {

}
