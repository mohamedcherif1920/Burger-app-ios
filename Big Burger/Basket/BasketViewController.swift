//
//  BasketViewController.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

class BasketViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var clearBasketButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var basketTableView: UITableView!
    // MARK: - Properties
    public var viewModel: BasketViewModel
    var basketArray = [BasketModel]()
    private let formatter = MoneyFormatter()
    // MARK: - Init
    public required init(viewModel: BasketViewModel) {
      self.viewModel = viewModel
      super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let isRealmArray = viewModel.getSomeObject() else {
               return
           }
        basketArray  = isRealmArray
        basketTableView.register(BasketTableViewCell.self)
        setupButton()
        setupUI()
    }
    
    // MARK: - Functions
    func setupUI() {
        clearBasketButton.layer.cornerRadius = 22
        clearBasketButton.layer.borderWidth = 1
        clearBasketButton.layer.borderColor = UIColor.init(red: 26, green: 162, blue: 176, alpha: 1).cgColor
    }
    
    func setupButton() {
        
        backButton.rx.tap.asDriver()
          .drive(
            onNext: { [weak self] in
              guard let strongSelf = self else { return }
              strongSelf.dismiss(animated: true, completion: nil)
            }
        )
          .disposed(by: disposeBag)
        
        clearBasketButton.rx.tap.asDriver()
          .drive(
            onNext: { [weak self] in
              guard let strongSelf = self else { return }
                strongSelf.viewModel.deleteRealm(strongSelf.basketArray)
              strongSelf.dismiss(animated: true, completion: nil)
            }
        )
          .disposed(by: disposeBag)
        
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(BasketTableViewCell.self)
        cell.selectionStyle = .none
        let basket = basketArray[indexPath.row]
        cell.descLbl.text = basket.descriptionResto
        cell.titleLbl.text = basket.title
        cell.quantityLbl.text = basket.quantity + "x"
        cell.priceLbl.text =  "\(formatter.string(from: basket.price , currency: true))"
        return cell
    }
    
    
}
