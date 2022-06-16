//
//  CartViewController.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-16.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    func ProductsSuccess(products: Products,keys: [String])
}


class CartViewController: UIViewController,CartViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    private var viewModel: CartViewModelProtocol!
    let coreData = CoreDataManager.shared
    private var totalPrice : Double = 0.0
    var products: Products?
    var keys: [String] = []{
            didSet{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartViewModel(view: self)
        viewModel.productsResult()
        priceLabel.text = "\(totalPrice)$"
        tableViewHandler()
        
//        products = coreData.getProducts()
        
        
    }
    
    
    private func registerCell(){
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func tableViewHandler(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        registerCell()
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
       
        let key = keys[indexPath.row]
        guard let product = products?[key] else{return UITableViewCell()}
        cell.handleCell(product: product,key: key)
        cell.plusButton.isEnabled = false
        if let price = product.retailPrice ?? product.costPrice {
        totalPrice += Double(price)
        }
        
        
        priceLabel.text = "\(totalPrice)$"
        return cell
    }
    
    
    
    
    
    
}
extension CartViewController{
    
    func ProductsSuccess(products: Products, keys: [String]) {
        self.products = products
        self.keys = keys
    }
}
