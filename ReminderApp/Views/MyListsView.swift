//
//  MyListsView.swift
//  ReminderApp
//
//  Created by Mykyta Yarovoi on 20.03.2025.
//

import SwiftUI

struct MyListsView: View {
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                                .font(.title3)
                            Divider()
                        }
                    }
                }.scrollContentBackground(.hidden)
                    .navigationDestination(for: MyList.self) { myList in
                        MyListDetailView(myList: myList)
                            .navigationTitle(myList.name)
                    }
            }
        }
    }
}
