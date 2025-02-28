import Foundation


class Product {
    var id : UUID = UUID()
    var name: String = ""
    var quantity : Int = 0
    var price : Int = 0
    
    init(name: String, quantity: Int, price: Int) {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}
class History {
    var id : UUID = UUID()
    var productName: String = ""
    var quantity : Int = 0
    var timestamp: Date = Date.now
    var price : Int = 0
    
    init(productName: String, quantity: Int, price: Int) {
        self.productName = productName
        self.quantity = quantity
        self.price = price
    }
}



class ProductManager{
    var productList : [Product] = [
        Product(name: "Pants", quantity: 20, price: 25),
        Product(name: "Shoes", quantity: 50, price: 35),
        Product(name: "Hats", quantity: 10, price: 15),
        Product(name: "Tshirts", quantity: 10, price: 50),
        Product(name: "Dresses", quantity: 24, price: 70),
    ]
    
    var historyList: [History] = [];
        
        
    func addNewStudent(newProduct: Product) {
        productList.append(newProduct)
    }
        
    func deleteOneStudent(idtodelete: UUID)  {
        productList.removeAll { product in
            return product.id == idtodelete
        }
    }
    
    func updateQuantity(productID:UUID, newQuatity:Int){
        let product = productList.first { Product in
                Product.id == productID
            }
        if (product != nil) {
            product?.quantity = newQuatity
        }
    }
    
    func buyProduct(productID:UUID, newQuatity:Int){
        let product = productList.first { Product in
                Product.id == productID
            }
        if (product != nil) {
            product?.quantity -= newQuatity
            historyList.append(History(productName: product?.name ?? "", quantity: newQuatity, price: (newQuatity * (product?.price ?? 0))))
        }
    }
    
    func isAvaliable(productID:UUID, quatity:Int) -> Bool{
        let product = productList.first { Product in
                Product.id == productID
            }
        if (product != nil && quatity <= product!.quantity) {
            return true
        }
        else{
            return false
        }
    }
}
