//
//  AddFundItemView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/28/23.
//

import SwiftUI

struct AddFundItemView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var itemName: String = ""
    @State private var itemCost: Double = 0.00
    @State private var costString: String = ""
    @State private var isTyping: Bool = false
    @State private var isDeposit = "Deposit"
    
    var purchaseOptions = ["Purchase", "Deposit"]
    
    let fund: FundEntity
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                   Picker("", selection: $isDeposit) {
                       ForEach(purchaseOptions, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(.segmented)
                }
                
                if isDeposit == "Purchase" {
                    HStack {
                        Text("Item Name")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        TextField("Name", text: $itemName)
                            .frame(width: 200)
                            .padding(10)
                            .scrollContentBackground(.hidden) // <- Hide it
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(10)
                    }
                }
                
                CostPicker(isTyping: $isTyping, cost: $itemCost, costString: $costString, title: "Item Cost")
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", action: {
                        
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", action: {
                        DataController.shared.addFundItem(
                            fund: fund,
                            itemName: itemName,
                            itemCost: itemCost,
                            balance: fund.balance,
                            isPositive: isPositive(),
                            context: moc
                        )
                    })
                }
            }
        }
    }
    
    private func isPositive() -> Bool {
        if self.isDeposit == "Purchase" {
            return false
        } else {
            return true
        }
    }
}

#Preview {
    AddFundItemView(fund: FundEntity())
}
