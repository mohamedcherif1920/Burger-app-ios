//
//  DetailRestoViewController.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import RealmSwift

class DetailRestoViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descrptionLbl: UILabel!
    @IBOutlet weak var tiltleLbl: UILabel!
    @IBOutlet weak var detailRestoImg: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addBasketButton: UIButton!
    // MARK: - Properties
    public var viewModel: DetaiRestoViewModel
    var restaurant = RestoarauntModel()
    var basket = BasketModel()
    var elementsInBasket = [BasketModel]()
    private let formatter = MoneyFormatter()
    // MARK: - Init
    public required init(viewModel: DetaiRestoViewModel) {
      self.viewModel = viewModel
      super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
    }
    
    func setupUI() {
        
        let urlString = restaurant.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlLogo = URL(string: urlString)
        tiltleLbl.text = restaurant.title
        descrptionLbl.text = restaurant.description
        priceLbl.text = "\(formatter.string(from: restaurant.price ?? 0 , currency: true))"
        detailRestoImg.kf.setImage(with: urlLogo)
        addBasketButton.layer.cornerRadius = 22
        addBasketButton.layer.borderWidth = 1
        addBasketButton.layer.borderColor = UIColor.init(red: 26, green: 162, blue: 176, alpha: 1).cgColor
    }
  
    func setupButton() {
        stepper.rx.value.asObservable()
               .map { Int($0).description }
               .bind(to: quantityLbl.rx.text)
               .disposed(by: disposeBag)
        
        backButton.rx.tap.asDriver()
          .drive(
            onNext: { [weak self] in
              guard let strongSelf = self else { return }
              strongSelf.dismiss(animated: true, completion: nil)
            }
        )
          .disposed(by: disposeBag)
        
        addBasketButton.rx.tap.asDriver()
          .drive(
            onNext: { [weak self] in
              guard let strongSelf = self else { return }
                strongSelf.basket.title = strongSelf.restaurant.title ?? ""
                strongSelf.basket.descriptionResto = strongSelf.restaurant.description ?? ""
                strongSelf.basket.ref = strongSelf.restaurant.ref ?? ""
                strongSelf.basket.price = strongSelf.restaurant.price ?? 0
                strongSelf.basket.quantity = strongSelf.quantityLbl.text ?? ""
                strongSelf.elementsInBasket.append(strongSelf.basket)
                strongSelf.viewModel.saveRealmArray(strongSelf.elementsInBasket)

              strongSelf.dismiss(animated: true, completion: nil)
            }
        )
          .disposed(by: disposeBag)
        
    }

}
