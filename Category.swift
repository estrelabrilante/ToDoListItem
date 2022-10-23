//
//  Category.swift
//  Todoey
//
//  Created by user215496 on 10/22/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object{
    @objc dynamic var name : String = ""
    //forward relationship
    let items = List<Item>()
    
}

