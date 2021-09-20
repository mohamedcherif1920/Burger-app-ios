//
//  BaseViewController.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    
    public init() {
      guard String(describing: type(of: self)) != "BaseViewController" else { fatalError("Must use subclass ") }
      super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    /**
     Use this method if the nib name is different from the subclass name.
     */
    public init(withNibName nibName: String) {
      super.init(nibName: nibName, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented. Use init() instead and make sure to have to xib file with the same file name as the class file.")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
