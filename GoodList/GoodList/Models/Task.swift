//
//  Task.swift
//  GoodList
//
//  Created by Keshav Kishore on 20/06/22.
//

import Foundation



enum Priority: Int {
    case high
    case medium
    case low
}



struct Task {
    let title: String
    let priority: Priority
}
