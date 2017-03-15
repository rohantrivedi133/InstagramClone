//
//  HomeViewController.swift
//  instagram-clone
//
//  Created by Rohan Trivedi on 3/5/17.
//  Copyright © 2017 Rohan Trivedi. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        getPosts()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let posts = posts
        {
            return posts.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostCell
        
        if posts != nil
        {
            let post = posts![indexPath.row]
            cell.post = post
        }
        
        return cell
    }
    
    func getPosts()
    {
        let query = PFQuery(className: "Post")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts
            {
                self.posts = posts
                self.tableView.reloadData()
            }
            else
            {
                print(error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any)
    {
        print("Logging out current user")
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil
            {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
}
