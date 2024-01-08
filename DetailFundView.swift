//
//  DetailFundView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/27/23.
//

import SwiftUI
import Charts

struct DetailFundView: View {
    @State private var search: String = ""
    @State private var isAddingItem: Bool = false
    
    @State private var collapseChart: Bool = false
    
    @FetchRequest var items: FetchedResults<FundItem>
    @FetchRequest var dataPoints: FetchedResults<DataPoint>
    
    let fund: FundEntity
    
    init(fund: FundEntity) {
        self.fund = fund
        
        _items = FetchRequest(
            entity: FundItem.entity(),
            sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)],
            predicate: NSPredicate(format: "fund == %@", fund)
        )
        
        _dataPoints = FetchRequest(
            entity: DataPoint.entity(),
            sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)],
            predicate: NSPredicate(format: "fund == %@", fund)
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(searchResults) { item in
                        ItemRow(name: item.name ?? "", cost: item.price, date: item.date ?? Date(), isDeposit: isDeposit(item: item))
                    }
                    .modifier(BentoBox())
                    .padding(.horizontal)
                }
            }
            .navigationTitle(fund.name ?? "Data Not Found")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $search)
            .safeAreaInset(edge: .bottom) {
                VStack {
                    VStack {
                        HStack {
                            Text(doubleToDollar(fund.balance))
                                .font(.system(size: 36))
                                .fontWeight(.semibold)
                            
                            isTrendingUpView()
                            
                            Spacer()
                            
                            Button {
                                self.collapseChart.toggle()
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        if !collapseChart {
                            ChartView(dataPoints: dataPoints)
                                .frame(maxHeight: 100)
                        }
                    }
                    .modifier(BentoBox())
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn, value: collapseChart)
                    
                    HStack {
                        Button {
                            self.isAddingItem = true
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                    
                                Text("New Purchase")
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
                .padding(.horizontal)
            }
            .sheet(isPresented: $isAddingItem) {
                AddFundItemView(fund: fund)
            }
        }
    }
    
    private var searchResults: [FundItem] {
        if search.isEmpty {
            return Array(items)
        } else {
            return Array(items).filter { $0.name!.contains(search) }
        }
    }
    
    private func isTrendingUpView() -> some View {
        if items.isEmpty {
            isTrendingUp(image: "minus.square.fill", color: Color.orange)
        } else if items.first?.name == "" {
            isTrendingUp(image: "arrow.up.forward.square.fill", color: Color.green)
        } else {
            isTrendingUp(image: "arrow.down.forward.square.fill", color: Color.red)
        }
    }
}

struct DetailFundView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFundView(fund: FundEntity())
    }
}


struct isTrendingUp: View {
    let image: String
    let color: Color
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .renderingMode(.template)
            .frame(width: 36, height: 36)
            .foregroundColor(color)
    }
}
