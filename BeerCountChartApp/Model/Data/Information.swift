//
//  Information.swift
//  Responsive
//
//  Created by NomoteteS on 1.01.2023.
//

import SwiftUI

// MARK: Info Cards And Sample Data

struct Info: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var amount: String
    var percentage: Int
    var loss: Bool = false
    var icon: String
    var iconColor: Color
}

var infos: [Info] = [
Info(title: "Revengue", amount: "$2.047", percentage: 10, loss: true , icon: "arrow.up.right", iconColor: Color("Purple")),
Info(title: "Orders", amount: "356", percentage: 20, icon: "cart", iconColor: Color.green),
Info(title: "Dine in", amount: "220", percentage: 10, icon: "fork.knife", iconColor: Color.red),
Info(title: "Take away", amount: "135", percentage: 5, loss: true, icon: "takeoutbag.and.cup.and.straw.fill", iconColor: Color.yellow)
]
