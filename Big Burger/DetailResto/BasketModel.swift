//
//  BasketModel.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
import RealmSwift

class BasketModel: Object {
  @objc dynamic var ref = ""
  @objc dynamic var title = ""
  @objc dynamic var descriptionResto = ""
  @objc dynamic var price = 0
  @objc dynamic var quantity = ""
  @objc dynamic var row = 0

}

