//
//  Models.swift
//  Smart Household
//
//  Created by Дмитрий Канский on 14.03.2022.
//

import Foundation


class ProductJSON: Decodable {
    var id: Int
    var name: String
    var description: String
    var count: String
    var measure: String
    var picture: String
    var tag: String
}
