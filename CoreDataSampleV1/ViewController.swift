//
//  ViewController.swift
//  CoreDataSampleV1
//
//  Created by Burak Akin on 10.08.2018.
//  Copyright © 2018 Burak Akin. All rights reserved.
//

import UIKit

var array = ["burk","ayşe"]

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func addFav(sender: UIButton) {
        print("selam")
        let rowSelected = sender.tag
        print(rowSelected)
    }
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = array[indexPath.row]
        cell.favButton.tag = indexPath.row
        
        cell.favButton.addTarget(self, action: #selector(addFav(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    
}
