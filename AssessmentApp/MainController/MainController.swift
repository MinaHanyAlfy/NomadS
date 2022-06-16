//
//  MainController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit

#warning("""
The initial viewcontroller should show the shopping basket.
It should contain a 'Plus' button for adding new items to the basket.
It should contain a 'Clear' button for removing all items in the basket.
""")

protocol MainViewProtocol: AnyObject {
    func ProductsSuccess(products: Products,keys: [String])
}
class MainController: UIViewController,MainViewProtocol {
    
    private var viewModel: MainViewModelProtocol!
    private var products: Products = [:]
    private var keys: [String] = []{
        didSet{
            DispatchQueue.main.async { [self] in
                if keys.isEmpty{
                    self.noProductsViewLayout()
                    
                }else{
                    tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    ///TableView is embedded in the ScrollView.
    ///Set the Size of table view  on the basis of content in it.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(view: self)
        viewModel.productsResult()
        tableViewHandler()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    @IBAction func cartAction(_ sender: Any) {
        
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        let key = keys[indexPath.row]
        guard let product = products[key] else{return UITableViewCell()}
        cell.handleCell(product: product,key: key)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = keys[indexPath.row]
    
        
        performSegue(withIdentifier: "productDetail", sender: key)
    }
}
extension MainController{
    
    func ProductsSuccess(products: Products,keys: [String]) {
        self.products = products
        self.keys = keys
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let product = products[ sender as? String ?? "" ] else{return}
        if segue.identifier == "productDetail"{
        
            let deVc = segue.destination as! DetailController
            deVc.product = product
            
        }
        if segue.identifier == "productsCart" {
            let cartVc = segue.destination as! CartViewController
            
            
        }
        
    }
    private func noProductsViewLayout(){
        DispatchQueue.main.async {[self] in
            print("No Layout")
            tableView.isHidden = true
            let noProudctView = ZeroStateView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.width/2))
            noProudctView.center = view.center
            view.addSubview(noProudctView)
        }
        
    }
    
}
