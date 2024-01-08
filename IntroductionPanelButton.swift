//
//  IntroductionPanelButton.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct IntroductionPanelButton: View {
    @Binding var panel: Int
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                self.panel -= 1
            } label: {
                Text("Go Back")
                    .padding()
                    .background(.black)
                    .cornerRadius(15)
            }
            
            Button {
               action()
            } label: {
                HStack {
                    Text("Continue")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("primaryGreen"))
                .cornerRadius(15)
            }
        }
        .foregroundStyle(.white)
        .fontWeight(.bold)
        .font(.subheadline)
    }
}

#Preview {
    IntroductionPanelButton(panel: .constant(1), action: {})
}
