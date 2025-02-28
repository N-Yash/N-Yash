import UIKit

class RestockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restockTable: UITableView!
    var model: ProductManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        restockTable.dataSource = self
        restockTable.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.productList.count ?? 0
    }
    @IBOutlet weak var amountIB: UITextField!
    
    @IBAction func restock(_ sender: Any) {
        if let index = restockTable.indexPathForSelectedRow?.row
        {
            if let stock:Int = Int(amountIB.text ?? ""){
                let localModel =  model!
                localModel.updateQuantity(productID: localModel.productList[index].id, newQuatity: localModel.productList[index].quantity + stock)
                restockTable.reloadData()
            } else {
                let alert = UIAlertController(title: "Alert", message: "Invalid Restock Amount", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: false)
            }
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please Select Product To Restock", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restockCell") ?? UITableViewCell()
        cell.textLabel?.text = model?.productList[indexPath.row].name
        cell.detailTextLabel?.text! = String(model?.productList[indexPath.row].quantity ?? 0)
        
        return cell
    }

    @IBAction func onCancel(_ sender: Any) {
        restockTable.deselectRow(at: restockTable.indexPathForSelectedRow!, animated: true)
    }

}
