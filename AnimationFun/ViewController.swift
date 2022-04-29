//
//  ViewController.swift
//  AnimationFun
//
//  Created by Ana Cvasniuc on 28/04/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // the data for the table view cells
    let cellAnimation: [String] = ["Move", "Scale", "Rotate", "Shake", "Circling"]
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle?.title = "Core Animation Examples"
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellAnimation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        // set the text from the data model
        cell.textLabel?.text = self.cellAnimation[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let secondViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
        //passo in base alla riga il nome della cella come title 
            secondViewController.title = cellAnimation[indexPath.row]
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
}

