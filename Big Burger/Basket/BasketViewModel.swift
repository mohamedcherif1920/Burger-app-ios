//
//  BasketViewModel.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
import RealmSwift
class BasketViewModel: BaseViewModel {
  // MARK: Init
  public required init() {
    
  }
    
    func getSomeObject() -> [BasketModel]? {
      let defaultRealm = try! Realm()
       let objects = defaultRealm.objects(BasketModel.self).toArray(ofType : BasketModel.self) as [BasketModel]

       return objects.count > 0 ? objects : nil
   }
    
    func deleteRealm(_ objects: [BasketModel]) {
        let realm = try! Realm()
        // Persist your data easily with a write transaction
        try! realm.write {
            realm.deleteAll()
        }
    }
}
