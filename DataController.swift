//
//  DataController.swift
//  Budget
//
//  Created by Daniel Madjar on 12/28/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { description, err in
            if let err = err {
                print("Failed to load the data \(err.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved.")
        } catch {
            print("Data could not be saved.")
        }
    }
    
    func deposit(fund: FundEntity, itemCost: Double, context: NSManagedObjectContext) {
        fund.balance = fund.balance + itemCost
        save(context: context)
    }
    
    func subtractBalance(fund: FundEntity, itemCost: Double, context: NSManagedObjectContext) {
        fund.balance = fund.balance - itemCost
        save(context: context)
    }
    
    func addFund(name: String, balance: Double, context: NSManagedObjectContext) {
        let fund = FundEntity(context: context)
        fund.id = UUID()
        fund.name = name
        fund.balance = balance
        
        let dataPoint = DataPoint(context: context)
        dataPoint.id = UUID()
        dataPoint.balance = balance
        dataPoint.date = Date()
        
        fund.addToDataPoints(dataPoint)
        
        save(context: context)
    }
    
    func addFundItem(
        fund: FundEntity, 
        itemName: String,
        itemCost: Double,
        balance: Double,
        isPositive: Bool,
        context: NSManagedObjectContext
    ) {
        if isPositive {
            deposit(fund: fund, itemCost: itemCost, context: context)
        } else {
            subtractBalance(fund: fund, itemCost: itemCost, context: context)
        }
        
        let item = FundItem(context: context)
        item.id = UUID()
        item.name = itemName
        item.price = itemCost
        item.date = Date()
        
        let dataPoint = DataPoint(context: context)
        dataPoint.id = UUID()
        dataPoint.balance = fund.balance
        dataPoint.date = Date()
        
        fund.addToItems(item)
        fund.addToDataPoints(dataPoint)
        
        save(context: context)
    }
    
    func deleteFund(fund: FundEntity, context: NSManagedObjectContext) {
        context.delete(fund)
        save(context: context)
    }
}
