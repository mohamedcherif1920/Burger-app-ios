//
//  RestaurantModel.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
struct RestoarauntModel: Codable {
    var ref: String?
    var title: String?
    var description: String?
    var thumbnail: String?
    var price: Int?
   
   
    private enum CodingKeys: String, CodingKey {
        case ref
        case title
        case description
        case thumbnail
        case price 
       
     
    }
}
