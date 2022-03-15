//
//  ChemicalsViewController.swift
//  Smart Household
//
//  Created by Дмитрий Канский on 15.03.2022.
//

import UIKit
import Alamofire

class ChemicalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet var ProductTableView: UITableView!
    
    var ProductID: [Int] = []
    var ProductNames: [Int:String] = [:]
    var ProductInfo: [Int:String] = [:]
    var ProductAmmount: [Int:String] = [:]
    var ProductMeasure: [Int:String] = [:]
    var ProductPicture: [Int:UIImage] = [:]
    var ProductTags: [Int:[String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProductTableView.delegate = self
        self.ProductTableView.dataSource = self
        self.registerTableViewCells()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let AFGroup = DispatchGroup()
        
        for i in 1...100 {
            AFGroup.enter()
            AF.request("http://192.168.1.80:8000/products/" + String(i)).responseData { response in //Поменять IP на свой
                guard let data = response.value else { return }
                do {
                    let serverresponse = try JSONDecoder().decode(ProductJSON.self, from: data)
                    if serverresponse.tag.components(separatedBy: ";")[0] == "***CHEMICAL***" {
                        self.ProductID.append(serverresponse.id)
                        self.ProductNames[serverresponse.id] = serverresponse.name
                        self.ProductInfo[serverresponse.id] = serverresponse.description
                        self.ProductAmmount[serverresponse.id] = serverresponse.count
                        self.ProductMeasure[serverresponse.id] = serverresponse.measure
                        self.ProductTags[serverresponse.id] = serverresponse.tag.components(separatedBy: ";")
                        if serverresponse.picture != "" {
                            let imageurl = URL(string: serverresponse.picture)
                            let imagedata = try? Data(contentsOf: imageurl!)
                            self.ProductPicture[serverresponse.id] = UIImage(data: imagedata!)
                        }
                    }
                    print(serverresponse.id)
                } catch {
                    print(error)
                }
                AFGroup.leave()
            }
        }
            
            AFGroup.notify(queue: .main) {
                self.ProductID.sort()
                self.ProductTableView.reloadData()
                }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.ProductID.count)
        return self.ProductID.count + 1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (self.ProductTableView.numberOfRows(inSection: 0) - 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProduct", for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! ProductCell
        cell.CellName.delegate = self
        cell.CellInfo.delegate = self
        cell.CellCounter.delegate = self
        let i = ProductID[indexPath.row]
        if ProductPicture.keys.contains(i) {
            cell.CellImage.contentMode = .scaleAspectFit
            cell.CellImage.image = ProductPicture[i]
        }
        cell.CellName.text = ProductNames[i]
        cell.CellInfo.text = ProductInfo[i]
        cell.CellButtons.value = Double(ProductAmmount[i]!)!
        cell.CellCounter.text = (ProductAmmount[i]! + " " + ProductMeasure[i]!)
        return cell
    }
    
    private func registerTableViewCells() {
        var ProductCellNib = UINib(nibName: "ProductCell", bundle: nil)
        self.ProductTableView.register(ProductCellNib, forCellReuseIdentifier: "Product")
        ProductCellNib = UINib(nibName: "AddProductCell", bundle: nil)
        self.ProductTableView.register(ProductCellNib, forCellReuseIdentifier: "AddProduct")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            ProductTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        ProductTableView.contentInset = .zero
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
