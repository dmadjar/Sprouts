//
//  FundsView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/26/23.
//

import SwiftUI
import CoreData

struct FundsView: View {
    @FetchRequest(sortDescriptors: []) private var myFunds: FetchedResults<FundEntity>
    
    @Environment(\.managedObjectContext) var moc
    
    @AppStorage("FundFormat") private var usingListView: Bool = true
    
    @State private var isCreatingFund: Bool = false
    @State private var search: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if usingListView {
                    List {
                        ForEach(searchResults) { fund in
                            NavigationLink {
                                DetailFundView(fund: fund)
                            } label: {
                                FundRow(name: fund.name ?? "Not Found", money: doubleToDollar(fund.balance), isTrendingUp: recentItem(fund: fund))
                            }
                        }
                        .onDelete(perform: deleteFund)
                    }
                    .listStyle(.inset)
                } else {
                    ScrollView {
                        ForEach(searchResults) { fund in
                            HStack(spacing: 10) {
                                if isEditing {
                                    Button {
                                        DataController.shared.deleteFund(fund: fund, context: moc)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundStyle(Color("cardinal"))
                                            .font(.title2)
                                    }
                                    .transition(.scale)
                                    .animation(.easeInOut, value: isEditing)
                                }
                                
                                NavigationLink {
                                    DetailFundView(fund: fund)
                                } label: {
                                    CardView(fund: fund, isTrendingUp: recentItem(fund: fund), isEditing: $isEditing)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .toolbar(.hidden, for: .automatic)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            self.isCreatingFund.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                    
                                Text("New Fund")
                            }
                            .padding()
                            .background(Color("secondaryGreen"))
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                            .font(.system(size: 17).weight(.semibold))
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 25)
                    .shadow(radius: 5)
                }
            }
            .safeAreaInset(edge: .top) {
                CustomNavBar(usingListView: $usingListView, search: $search, isEditing: $isEditing)
                    .padding(.horizontal)
                    .background(.white)
            }
            .sheet(isPresented: $isCreatingFund) {
                CreateFundView(isCreatingFund: $isCreatingFund)
            }
        }
    }
    
    private var searchResults: [FundEntity] {
        if search.isEmpty {
            return Array(myFunds)
        } else {
            return Array(myFunds).filter { $0.name!.contains(search) }
        }
    }
    
    private func deleteFund(at offsets: IndexSet) {
        offsets.map { myFunds[$0] }.forEach(moc.delete)
        
        DataController.shared.save(context: moc)
    }
}

func isDeposit(item: FundItem) -> Bool {
    if item.name == "" {
        return true
    } else {
        return false
    }
}

func recentItem(fund: FundEntity) -> Bool {
    if fund.items!.count == 0 {
        return true
    } else {
        return isDeposit(item:
            fund.items?.sortedArray(using: [NSSortDescriptor(key: "date", ascending: true)]).last as! FundItem
        )
    }
}

func doubleToDollar(_ money: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    
    if let formattedTipAmount = formatter.string(from: money as NSNumber) {
       return "\(formattedTipAmount)"
    }

    return "$-"
}

struct FundsView_Previews: PreviewProvider {
    static var previews: some View {
        FundsView()
    }
}
