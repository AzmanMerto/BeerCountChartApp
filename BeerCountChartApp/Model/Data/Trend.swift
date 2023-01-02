//
//  Trend.swift
//  Responsive
//
//  Created by NomoteteS on 1.01.2023.
//

import SwiftUI

// MARK: Trending Dished Model and Sample Data
struct Trending: Identifiable {
    var id : String = UUID().uuidString
    var title: String
    var subTitle: String
    var count: Int
    var image: String
}

var tredingDishes: [Trending] = [
    Trending(title: "Regular Glass", subTitle: "Order", count: 400, image: "Beer1"),
    Trending(title: "Wine Glass", subTitle: "Order", count: 200, image: "Beer2"),
    Trending(title: "Coke glass", subTitle: "Order", count: 100, image: "Beer3")
    ]
