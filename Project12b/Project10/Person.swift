//
//  Person.swift
//  Project10
//
//  Created by Güven Karanfil on 28.12.2020.
//  Copyright © 2020 Güven Karanfil. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
