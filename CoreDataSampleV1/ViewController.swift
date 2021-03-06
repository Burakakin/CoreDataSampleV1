//
//  ViewController.swift
//  CoreDataSampleV1
//
//  Created by Burak Akin on 10.08.2018.
//  Copyright © 2018 Burak Akin. All rights reserved.
//

import UIKit
import CoreData

var array = ["burk","meh","özle"]

let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
let fav = Fav(context: context)

class ViewController: UIViewController {

    var buttonClickedOnce = true
    var checkFav = [Fav]()
    
   
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addFavorite(for name : String) throws -> Bool {
        let request : NSFetchRequest<Fav> = Fav.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        request.fetchLimit = 1
        if let _ = try context.fetch(request).first {
            print("Zaten ekledin")
            return false // record exists
        } else {
            let fav = Fav(context: context)
            fav.name = name
            appDelegate.saveContext()
            print("Eklendi")
            return true // record added
        }
    }
    
    
    func deleteFav(for name : String) throws -> Bool {
        let request : NSFetchRequest<Fav> = Fav.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        request.fetchLimit = 1
        if let deleteRecord = try context.fetch(request).first {
            context.delete(deleteRecord)
            try context.save()
            print("Sildin")
            return false // record exists
        } else {
            return true
        }
    }
    
    
    @objc func addFav(sender: UIButton) {
        
        let rowSelected = sender.tag
        let name = array[rowSelected]
        //print("Selam \(name)")

        if buttonClickedOnce {
            sender.backgroundColor = UIColor.red
            buttonClickedOnce = false
            do{
                let _ = try addFavorite(for: name)
            } catch{
                print("Error")
            }
            
            
        }
        else{
            sender.backgroundColor = UIColor.clear
            buttonClickedOnce = true
            do{
                let _ = try deleteFav(for: name)
            } catch{
                print("Error")
            }
        }

       
        
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
