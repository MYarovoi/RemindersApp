//
//  ContentView.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddNewListView { name, color in
                        
                    }
                }
            }
        }
        .padding()
    }
}

    
    #Preview {
        HomeView()
    }

