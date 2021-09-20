//
//  RestaurantViewController.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import UIKit
import Kingfisher
import RealmSwift
import RxSwift
import RxCocoa

class RestaurantViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var restuarantTableView: UITableView!
    @IBOutlet weak var basketButton: SSBadgeButton!
    
    // MARK: - Properties
    public var viewModel: RestaurantViewModel
    var restoArray = [RestoarauntModel]()
    private let formatter = MoneyFormatter()
    var basketArray = [BasketModel]()
    var basketCount = 0
    var selectedItemRows = [Int]()
    // MARK: - Init
    public required init(viewModel: RestaurantViewModel) {
      self.viewModel = viewModel
      super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupButton()
        restuarantTableView.register(RestoTableViewCell.self)
        viewModel.getRestoList {
            data in
            self.restoArray = data
            DispatchQueue.main.async {
                self.restuarantTableView.reloadData()
            }
        }

     }
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    // MARK: - Functions
    func setupUI()  {

        self.basketCount = viewModel.getSomeObject()?.count ?? 0
        basketButton.badgeEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        basketButton.badge = String(basketCount)
        
        if basketCount == 0 {
            basketButton.badgeLabel.isHidden = true
        }
    }
    
    func setupButton() {
        basketButton.rx.tap.asDriver()
          .drive(
            onNext: { [weak self] in
              guard let strongSelf = self else { return }
                if strongSelf.basketCount != 0 {
                    let viewModell = BasketViewModel()
                    let vC = BasketViewController(viewModel: viewModell)
                    vC.modalPresentationStyle = .fullScreen
                    strongSelf.present(vC, animated: true, completion: nil)
                }
            }
        )
          .disposed(by: disposeBag)
    }

}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(RestoTableViewCell.self)
        cell.selectionStyle = .none
        let restaurant = restoArray[indexPath.row]
        let urlString = restaurant.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlLogo = URL(string: urlString)
        cell.titleLbl.text = restaurant.title
        cell.descriptionLbl.text = restaurant.description
        cell.priceLbl.text =  "\(formatter.string(from: restaurant.price ?? 15, currency: true))"
        cell.restoImg.kf.setImage(with: urlLogo)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemRows.append(indexPath.row)
        let viewModell = DetaiRestoViewModel()
        let vC = DetailRestoViewController(viewModel: viewModell)
        vC.restaurant = restoArray[indexPath.row]
        vC.modalPresentationStyle = .fullScreen
        present(vC, animated: true, completion: nil)
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

