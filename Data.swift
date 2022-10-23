//
//  Data.swift
//  Todoey
//
//  Created by user215496 on 10/22/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
//Object is the class used to define Realm model objects: enable to persist Data class
class Data: Object{
    //dynamic is declaration modifier: tells the run time to use dynamic dispatch over the standard (static dispatch)
    //dynamic dispatch comes from obj-c API
  @objc dynamic var name :String = ""
   @objc dynamic var age : Int = 0
}
