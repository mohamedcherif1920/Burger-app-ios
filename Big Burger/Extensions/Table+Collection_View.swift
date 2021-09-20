//
//  Table+Collection_View.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
import UIKit

extension UITableView {
  
  func register<TVC: UITableViewCell>(_ tableViewCell: TVC.Type) {
    register(UINib(nibName: String(describing: tableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: tableViewCell.self))
  }
  
  func dequeueReusable<TVC>(_ tableViewCell: TVC.Type) -> TVC where TVC: UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: String(describing: tableViewCell.self)) as? TVC else {
      fatalError("Cannot create reusable cell with type \(String(describing: tableViewCell.self))). Did you register the cell for the table view? Did you set the cell identifier right?")
    }
    return cell
  }
}

extension UICollectionView {
  
  func registercoll<TVC: UICollectionViewCell>(_ collectionViewCell: TVC.Type) {
    register(UINib(nibName: String(describing: collectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: collectionViewCell.self))
  }
}
