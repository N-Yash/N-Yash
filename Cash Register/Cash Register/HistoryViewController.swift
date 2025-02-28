import UIKit

class HistoryViewController: UIViewController {

    var object : History?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var nameIB: UILabel!
    
    @IBOutlet weak var priceIB: UILabel!
    
    
    @IBOutlet weak var dateIB: UILabel!
    
    @IBOutlet weak var qtyIB: UILabel!
    
    func loadData(){
        if let data = object {
            self.title = data.productName
            nameIB.text = "Product Name: \(data.productName)"
            priceIB.text = "Product Price: \(data.price)"
            qtyIB.text = "Product Qty: \(data.quantity)"
            dateIB.text = "Product Date: \(data.timestamp.formatted())"
        }
    }

}
