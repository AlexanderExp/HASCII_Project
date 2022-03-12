//
//  ListViewController.swift
//  Smart Household
//
//  Created by Дмитрий Канский on 09.03.2022.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var ProductTableView: UITableView!
    override func viewDidLoad() {
        self.ProductTableView.delegate = self
        self.ProductTableView.dataSource = self
        self.registerTableViewCells()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID = "Product"
        if indexPath[1] == (self.ProductTableView.numberOfRows(inSection: 0) - 1) {
            cellID = "AddProduct"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        // Configure the cell...

        return cell
    }
    
    private func registerTableViewCells() {
        var ProductCellNib = UINib(nibName: "ProductCell", bundle: nil)
        self.ProductTableView.register(ProductCellNib, forCellReuseIdentifier: "Product")
        ProductCellNib = UINib(nibName: "AddProductCell", bundle: nil)
        self.ProductTableView.register(ProductCellNib, forCellReuseIdentifier: "AddProduct")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
