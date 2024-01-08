//
//  FundEntity+CoreDataProperties.swift
//  Budget
//
//  Created by Daniel Madjar on 1/4/24.
//
//

import Foundation
import CoreData


extension FundEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FundEntity> {
        return NSFetchRequest<FundEntity>(entityName: "FundEntity")
    }

    @NSManaged public var balance: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dataPoints: NSSet?
    @NSManaged public var items: NSOrderedSet?

}

// MARK: Generated accessors for dataPoints
extension FundEntity {

    @objc(addDataPointsObject:)
    @NSManaged public func addToDataPoints(_ value: DataPoint)

    @objc(removeDataPointsObject:)
    @NSManaged public func removeFromDataPoints(_ value: DataPoint)

    @objc(addDataPoints:)
    @NSManaged public func addToDataPoints(_ values: NSSet)

    @objc(removeDataPoints:)
    @NSManaged public func removeFromDataPoints(_ values: NSSet)

}

// MARK: Generated accessors for items
extension FundEntity {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: FundItem, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [FundItem], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: FundItem)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [FundItem])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: FundItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: FundItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}

extension FundEntity : Identifiable {

}
