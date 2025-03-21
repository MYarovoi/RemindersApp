//
//  SelectListView.swift
//  ReminderApp
//
//  Created by Никита Яровой on 21.03.2025.
//

import SwiftUI

struct SelectListView: View {
    @Binding var selectedList: MyList?
    
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchedResults: FetchedResults<MyList>
    
    var body: some View {
        List(myListsFetchedResults) { myList in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = myList
                }
                
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
