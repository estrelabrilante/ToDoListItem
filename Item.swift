//
//  Item.swift
//  Todoey
//
//  Created by user215496 on 10/22/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object{
 @objc dynamic var title: String = ""
 @objc dynamic var done: Bool = false
    //inverse relationship
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated :Date?
    
}
