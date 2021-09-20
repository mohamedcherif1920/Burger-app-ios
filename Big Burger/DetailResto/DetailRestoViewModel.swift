//
//  DetailRestoViewModel.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
import RealmSwift
class DetaiRestoViewModel: BaseViewModel {

  // MARK: Init
  public required init() {
    
  }
    func saveRealmArray(_ objects: [BasketModel]) {
        let realm = try! Realm()
        // Persist your data easily with a write transaction
        try! realm.write {

            realm.add(objects)
        }
        }

}
