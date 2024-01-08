//
//  CostPicker.swift
//  Budget
//
//  Created by Daniel Madjar on 12/28/23.
//

import SwiftUI

struct CostPicker: View {
    @Binding var isTyping: Bool
    @Binding var cost: Double
    @Binding var costString: String
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 18))
            
            Divider()
            
            HStack {
                if !isTyping {
                    Text(doubleToDollar(cost))
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .onTapGesture {
                            self.isTyping.toggle()
                        }
                } else {
                    HStack(spacing: 0) {
                        Text("$")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                        
                        TextField("\(String(format: "%.2f", cost))", text: $costString)
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .keyboardType(.numberPad)
                            .onChange(of: costString) {
                                withAnimation {
                                    self.cost = Double(costString) ?? 0.0
                                }
                            }
                    }
                }
                
                Spacer()
            }
            
            Slider(value: $cost, in: 0...1000)
        }
        .padding()
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    CostPicker(isTyping: .constant(false), cost: .constant(0.00), costString: .constant("0.00"), title: "Starting Amount")
}
