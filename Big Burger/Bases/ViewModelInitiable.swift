//
//  ViewModelInitiable.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
/**
 A view controller which wants to use a view model
 should adopt this protocol to make sure that the creator
 of the view controller can use the init to inject a view model.
 */
public protocol ViewModelInitiable {
  associatedtype Model
  var viewModel: Model { get }
  init(viewModel: Model)
}


