//
//  TabbarHelper.swift
//  FoodTruckAndBeer
//
//  Created by Abhinay Maurya on 12/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

struct TabItem {
    let title:String!
    let imageName:String!
}

final class TabbarHelper
{
    static let items = [
        TabItem(title: "Home", imageName: "home"),
        TabItem(title: "Progress", imageName: "progress"),
        TabItem(title: "Compare", imageName: "compare"),
        TabItem(title: "CME Info", imageName: "progress"),
        TabItem(title: "Resources", imageName: "resources")
    ]
}
