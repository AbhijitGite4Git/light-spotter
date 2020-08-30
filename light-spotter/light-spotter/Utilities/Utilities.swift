//
//  Utilities.swift
//  light-spotter
//
//  Created by Abhijit Gite on 30/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import Foundation
import Foundation
import Reachability

let reachability = try! Reachability()


func find(value searchValue: String, in array: [Cameras]) -> Cameras
   {
       for (index,value) in array.enumerated()
       {
           if value.camera_id == searchValue {
               return array[index]
           }
       }
       return Cameras()
   }
