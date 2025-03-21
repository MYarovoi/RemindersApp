//
//  CustomOperators.swift
//  ReminderApp
//
//  Created by Никита Яровой on 21.03.2025.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0})
}
