//
//  CreateFundView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/27/23.
//

import SwiftUI

struct Category: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let color: Color
}

struct CreateFundView: View {
    @Environment(\.managedObjectContext) var moc
    
    @Binding var isCreatingFund: Bool
   
    @State private var fundName: String = ""
    @State private var description: String = ""
    
    @State private var cost: Double = 0.0
    @State private var costString: String = ""
    
    @State private var isTyping: Bool = false
    
    @State private var selectedCategories: Set<Category> = []
    
    private let categories: [Category] = [
        Category(title: "Essential", color: Color.red),
        Category(title: "Leisure", color: Color.orange),
        Category(title: "Home", color: Color.yellow)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Text("Fund Name")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        TextField("Name", text: $fundName)
                            .frame(width: 200)
                            .padding(10)
                            .scrollContentBackground(.hidden) // <- Hide it
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Select Categories")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Divider()
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(categories) { cat in
                                    Button {
                                        if selectedCategories.contains(cat) {
                                            selectedCategories.remove(cat)
                                        } else {
                                            self.selectedCategories.insert(cat)
                                        }
                                    } label: {
                                        Text(cat.title)
                                            .padding(10)
                                            .background(.regularMaterial)
                                            .fontWeight(.regular)
                                            .background(selectedCategories.contains(cat) ? cat.color : Color.gray.opacity(0.10))
                                            .cornerRadius(15)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    
                    CostPicker(isTyping: $isTyping, cost: $cost, costString: $costString, title: "Starting Amount")
                
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Divider()
                        
                        TextEditor(text: $description)
                            .scrollContentBackground(.hidden) // <- Hide it
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(15)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(height: 250)
                }
                .padding()
            }
            .navigationTitle("Create New Fund")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", action: {
                        self.isCreatingFund.toggle()
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", action: {
                        DataController.shared.addFund(name: fundName, balance: cost, context: moc)
                    })
                }
            }
        }
    }
}

struct CreateFundView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFundView(isCreatingFund: .constant(true))
    }
}
