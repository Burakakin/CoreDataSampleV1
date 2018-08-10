//
//  FavoriteViewController.swift
//  CoreDataSampleV1
//
//  Created by Burak Akin on 10.08.2018.
//  Copyright © 2018 Burak Akin. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    var favs = [Fav]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let result = try context.fetch(Fav.fetchRequest())
            favs = result as! [Fav]
            
        } catch{
            print("Error")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coreCell", for: indexPath)
        let name = favs[indexPath.row]
        cell.textLabel?.text = name.name
        return cell
    }
    
    
    
    
    
    
    
    
}
