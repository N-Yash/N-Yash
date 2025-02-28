import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var productTable: UITableView!
    
    var model: ProductManager?
    @IBOutlet weak var typeIB: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var quantityIB: UILabel!
    
    var selectedProductID : UUID?
    var selectProduct : Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quantityIB.text = ""
        model = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        productTable.dataSource = self
        productTable.delegate = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.productList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") ?? UITableViewCell()
        cell.textLabel?.text = model?.productList[indexPath.row].name
        cell.detailTextLabel?.text! = String(model?.productList[indexPath.row].quantity ?? 0)
        
        return cell
    }
    
    
    
    @IBAction func onInput(_ sender: UIButton) {
        
        if selectProduct != nil {
            quantityIB.text! += sender.titleLabel?.text ?? ""
            let quantity = Int(quantityIB.text!) ?? 0
            let price = selectProduct?.price ?? 0
            print(quantity, price, (quantity * price))
            Total.text! = String((quantity * price))
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Please Select Type of Product", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: false)
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProductID = model?.productList[indexPath.row].id
        selectProduct = model?.productList[indexPath.row]
        typeIB.text = model?.productList[indexPath.row].name ?? "Error"
        if quantityIB.text?.count ?? 0 > 0 {
            let quantity = Int(quantityIB.text!) ?? 0
            let price = selectProduct?.price ?? 0
            Total.text! = String((quantity * price))
        }
    }
    
    @IBAction func onBuy(_ sender: UIButton) {
        
        
        if let id = selectedProductID {
            if quantityIB.text?.count ?? 0 > 0 {
                let amount = Int(quantityIB.text!)
                if ((model?.isAvaliable(productID: selectedProductID!, quatity: amount!))!) {
                    model?.buyProduct(productID: selectedProductID!, newQuatity: amount!)
                } else{
                    let alert = UIAlertController(title: "Alert", message: "Pruchase Failed, not sufficent stock", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: false)
                }
                productTable.reloadData()
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Please Enter Amount of Product for  Pruchase", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: false)
            }
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Please Select Type of Product", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: false)
        }
        Total.text = ""
        quantityIB.text = ""
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        productTable.reloadData()
    }
}

