//
//  ResturantViewModel.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
import RealmSwift
class RestaurantViewModel: BaseViewModel {

  // MARK: Init
  public required init() {
    
  }
    
    func getRestoList( completion: @escaping (_ result: [RestoarauntModel])-> Void) {

        var retoArray = [RestoarauntModel]()

        let urlApi = "https://bigburger.useradgents.com/catalog"
        guard let url = URL(string: urlApi) else {
                  return
                }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                   return
                 }
            do {
                retoArray = try JSONDecoder().decode([RestoarauntModel].self, from: data)
            } catch let JSONerror {
                print("error decoding JSON", JSONerror)
            }
              completion(retoArray)
         }.resume()
    }
    
     func getSomeObject() -> [BasketModel]? {
       let defaultRealm = try! Realm()
        let objects = defaultRealm.objects(BasketModel.self).toArray(ofType : BasketModel.self) as [BasketModel]

        return objects.count > 0 ? objects : nil
    }
    
   
}
