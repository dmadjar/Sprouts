//
//  PanelOne.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct PanelOne: View {
    @Binding var firstLaunch: Bool
    @Binding var panel: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Welcome to Sprouts!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("First we have to ask a couple questions to set up your budget!")
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(height: height * 0.06)
            
            VStack(alignment: .center, spacing: 0) {
                Image("threePlant")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(height: height * 0.18)
            
            Button {
                self.panel = 2
            } label: {
                HStack {
                    Text("Continue")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("primaryGreen"))
                .cornerRadius(15)
            }
            .frame(height: height * 0.08)
        }
        .frame(width: width * 0.84, height: height * 0.36, alignment: .topLeading)
        .modifier(BentoBox())
    }
}

#Preview {
    PanelOne(firstLaunch: .constant(true), panel: .constant(1))
}
