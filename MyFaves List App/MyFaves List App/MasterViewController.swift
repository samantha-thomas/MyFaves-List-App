//
//  MasterViewController.swift
//  MyFaves List App
//
//  Created by Samantha Thomas on 9/15/19.
//  Copyright © 2019 Samantha Thomas. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    // 1) comment out var objects line
    //var objects = [Any]()
    
    // 2) declare and initialize two arrays
    var ListOfPhotos:[UIImage] = []
    var ListOfFavs:[String]?
    var FavDetails:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Do any additional setup after loading the view, typically from a nib.
         navigationItem.leftBarButtonItem = editButtonItem
         
         let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
         navigationItem.rightBarButtonItem = addButton
         if let split = splitViewController
         {
         let controllers = split.viewControllers
         detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
         }
        }
         */
        
        
        //Menus
        ListOfPhotos = [
            UIImage(named: "mall.jpg")!,
            UIImage(named: "bike.jpg")!,
            UIImage(named: "googles.jpg")!,
            UIImage(named: "rvc.jpg")!,
            UIImage(named: "movies.jpg")!,
            UIImage(named: "recipes.jpg")!,
            UIImage(named: "car.jpg")!,
            UIImage(named: "groceries.jpg")!,
            UIImage(named: "apple.jpg")!,
            UIImage(named: "cnn.jpg")!,
        ]
        
        ListOfFavs = ["Home","Mall","Biking", "Google", "Movies", "Recipes", "Car", "Groceries", "Apple", "CNN"]
        FavDetails = ["https://www.rockvalleycollege.edu/","http://www.shopcherryvalemall.com/","http://www.bicycling.com", "http://www.google.com", "https://www.amctheatres.com/movie-theatres/rockford/amc-machesney-park-14", "https://www.allrecipes.com/recipe/21014/good-old-fashioned-pancakes/",  "https://www.porsche.com/usa/?gclsrc=aw.ds&&gclid=CjwKCAjwwvfrBRBIEiwA2nFiPaG3fdcvX3WgiYwmEA0ikQ54uiiKx7iRCykCVsyNtNCIlFa7-zKXCBoCHmoQAvD_BwE", "https://www.target.com/c/grocery/-/N-5xt1a?ref=tgt_adv_XS000000&AFID=google&fndsrc=tgtao&CPNG=BCM_Services&adgroup=General%2BDelivery%2BTerms&LID=700000001170706&LNM=groceries&MT=b&network=g&device=c&location=9021896&gclsrc=aw.ds&&gclid=CjwKCAjwwvfrBRBIEiwA2nFiPZVCQO8_A83Czsq3Js61sU7WxyfI4yW9WdNJGIn852IYgjX-H_r3MxoCw2cQAvD_BwE", "https://www.apple.com", "https://www.cnn.com"]
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     func insertNewObject(_ sender: Any)
     {
     objects.insert(NSDate(), at: 0)
     let indexPath = IndexPath(row: 0, section: 0)
     tableView.insertRows(at: [indexPath], with: .automatic)
     }
     */
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let object = FavDetails![indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.weburl = (object as AnyObject as? String)!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.title = ListOfFavs![indexPath.row]
            }
        }
    }
    
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 7) Replace objects.count with ListOfFavs!.count
        return ListOfFavs!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // 8) Replace code with below code until }
        cell.textLabel!.text = ListOfFavs![indexPath.row]
        let imagename:UIImage = ListOfPhotos[indexPath.row]
        cell.imageView?.image = imagename.resize(maxWidthHeight: 30)
        cell.detailTextLabel?.text = ">>"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        //9) Make below false
        return false;
    }
    
    /*
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
     {
         if editingStyle == .delete
         {
             objects.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
         }
         else if editingStyle == .insert
         {
     
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
         }
     }
     */
}


//10 Add image extension
extension UIImage {
    
    func resize(maxWidthHeight : Double)-> UIImage? {
        
        let actualHeight = Double(size.height)
        let actualWidth = Double(size.width)
        var maxWidth = 0.0
        var maxHeight = 0.0
        
        if actualWidth > actualHeight {
            maxWidth = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualWidth)
            maxHeight = (actualHeight * per) / 100.0
        }else{
            maxHeight = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualHeight)
            maxWidth = (actualWidth * per) / 100.0
        }
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
}
