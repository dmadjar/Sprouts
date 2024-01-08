//
//  CardView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI
import Charts

struct CardView: View {
    @FetchRequest var dataPoints: FetchedResults<DataPoint>
    @Environment(\.managedObjectContext) var moc
    
    @Binding var isEditing: Bool
    
    let fund: FundEntity
    let isTrendingUp: Bool
    
    init(fund: FundEntity, isTrendingUp: Bool, isEditing: Binding<Bool>) {
        self.fund = fund
        self.isTrendingUp = isTrendingUp
        
        _dataPoints = FetchRequest(
            entity: DataPoint.entity(),
            sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)],
            predicate: NSPredicate(format: "fund == %@", fund)
        )
        
        _isEditing = isEditing
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Text(fund.name ?? "Not Found")
                        .font(isEditing ? .title2 : .title)
                    
                    Image(systemName: isTrendingUp ? "arrow.up.forward.square.fill"
                          : "arrow.down.forward.square.fill")
                        .renderingMode(.template)
                        .foregroundStyle(isTrendingUp ? Color("primaryGreen") : Color("cardinal"))
                        .font(isEditing ? .title2 : .title)
                    
                    Spacer()
                    
                    Text(doubleToDollar(fund.balance))
                        .font(isEditing ? .title3 : .title2)
                }
                .fontWeight(.bold)
                .foregroundStyle(.black)
                
                if !isEditing {
                    ChartView(dataPoints: dataPoints)
                        .frame(maxHeight: 200)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: isEditing)
                }
            }
            .modifier(BentoBox())
            .padding(.vertical, 5)
    }
}

#Preview {
    CardView(fund: FundEntity(), isTrendingUp: true, isEditing: .constant(false))
}
