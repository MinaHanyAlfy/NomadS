//
//  CoreDataManager.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-15.
//

import Foundation
import UIKit
import CoreData
public class CoreDataManager{
    
    static public let shared = CoreDataManager()
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveProducts(products: Products){
        
        for (key, product) in products {
            
            let prd = ProductCD(context: context())
            prd.key = key
            prd.id = product.id
            prd.imageURL = product.imageURL
            prd.costPrice = Int64(product.costPrice ?? 0)
            prd.retailPrice = Int64(product.retailPrice ?? 0)
            prd.name = product.name
            prd.barcode = product.barcode
            prd.productsDescription = product.productsDescription
            do {
                try context().save()
                print("✅ Success")
            } catch let error as NSError {
                print(error)
            }
            
        }
        
        
    }
    func saveProduct(product: Product,key:String){
        
        let mangedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductCD", in: mangedContext)
        let productManagedObject = NSManagedObject(entity: entity!, insertInto: mangedContext)
            
        productManagedObject.setValue(product.id, forKey: "id")
        productManagedObject.setValue(product.imageURL, forKey: "imageURL")
        productManagedObject.setValue(product.barcode, forKey: "barcode")
        productManagedObject.setValue(product.retailPrice, forKey: "retailPrice")
        productManagedObject.setValue(product.costPrice, forKey: "costPrice")
        productManagedObject.setValue(product.productsDescription, forKey: "productsDescription")
        productManagedObject.setValue(product.name, forKey: "name")
        productManagedObject.setValue(key, forKey: "key")
          
            
            do {
                try mangedContext.save()
                print("✅ Success")
                print(productManagedObject)
            } catch let error as NSError {
                print(error)
            }
    
    
    }
    
    func countProducts() -> Int{
        let context = context()
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        
        return objects.count
    }
    
    func clearProducts() {
        let context = context()
        let fetchRequestProduct: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        let objects = try! context.fetch(fetchRequestProduct)
        
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save()
        } catch {
            print("❌ Error Delete Object")
        }
    }
    
    func getProducts() -> Products{
        let context = context()
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        guard let objects = try?  context.fetch(fetchRequest) else{return [:]}
        var products: Products = [:]
        for objc in objects {
            let product = Product(barcode: objc.barcode, productsDescription: objc.productsDescription, id: objc.id, imageURL: objc.imageURL, name: objc.name, retailPrice: Int(objc.retailPrice), costPrice: Int(objc.costPrice))
            if isExist(key: objc.key ?? ""){
                let uuid = NSUUID().uuidString
                products["\(objc.key)\(uuid)"] = product
                
            }else{
                products[objc.key ?? ""] = product
            }
        }
        return products
    }
    
    
    func isExist(key: String) -> Bool {
        
        let managedContext = context()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCD")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "key == %@" ,key)
        
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("❌ Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    
}
extension CoreDataManager{
    
    
    func context() ->  NSManagedObjectContext {
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
    
}
