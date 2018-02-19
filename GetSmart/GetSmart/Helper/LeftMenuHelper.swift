//
//  LeftMenuHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/28/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation


struct LeftSection {
    let title:String!
    let imageName:String!
}

enum Menu:Int{
    case Article = 0, About//, Faculty
}


final class LeftMenuHelper
{
    static let dataSource = [
        LeftSection(title: "Monographs", imageName: "article"),
        LeftSection(title: "About", imageName: "about"),
        //LeftSection(title: "Faculty", imageName: "faculty"),
    ]
}
