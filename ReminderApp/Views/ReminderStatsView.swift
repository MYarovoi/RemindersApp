//
//  ReminderStatsView.swift
//  ReminderApp
//
//  Created by Никита Яровой on 25.03.2025.
//

import SwiftUI

struct ReminderStatsView: View {
    let icon: String
    let title: String
    let count: Int?
    let iconColor: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .background(colorScheme == .dark ? Color.darkGray : Color.offWhite)
                .foregroundStyle(colorScheme == .dark ? Color.offWhite : Color.darkGray)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 10, iconColor: .red)
}
