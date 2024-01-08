//
//  CustomSearchBar.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var search: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .foregroundStyle(.gray)
            
            TextField("", text: $search, prompt: Text("Search").foregroundStyle(.gray))
                .font(.system(size: 17))
            
            Spacer()
            
            if !search.isEmpty {
                Button {
                    withAnimation {
                        self.search = ""
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundStyle(.gray)
                    
                }
            }
        }
        .padding(7)
        .background(.thickMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    CustomSearchBar(search: .constant(""))
}
