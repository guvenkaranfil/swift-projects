//
//  Petition.swift
//  Project7
//
//  Created by Güven Karanfil on 21.12.2020.
//  Copyright © 2020 Güven Karanfil. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
