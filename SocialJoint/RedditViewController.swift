//
//  RedditTableViewController.swift
//  SocialJoint
//
//  Created by Eric Dattore on 12/5/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let REDDIT_URL = "https://reddit.com/r/all.json"
    
    var posts = [Reddit]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        fetchLatestPosts()
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchLatestPosts() {
        guard let redditUrl = URL(string: REDDIT_URL) else {
            return
        }
        
        let request = URLRequest(url: redditUrl)
        
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data {
                    print(data)
                    self.posts = self.parseSubredditJson(data: data)
                    
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }
            }
        )
        
        task.resume()
    }
    
    func parseSubredditJson(data: Data) -> [Reddit] {
        var postList = [Reddit]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(
                with: data,
                options: JSONSerialization.ReadingOptions.mutableContainers
            ) as? NSDictionary
            
            let jsonReddit = (jsonResult?["data"] as! [String: AnyObject])["children"] as! [AnyObject]
            
            for reddit in jsonReddit {
                let reddit2 = (reddit as! [String: AnyObject])["data"] as! [String: AnyObject]
                
                let post = Reddit(
                    withTitle: reddit2["title"] as! String,
                    fromAuthor: reddit2["author"] as! String,
                    atUrl: "https://reddit.com" + (reddit2["permalink"] as! String)
                )
                
                postList.append(post)
            }
        } catch {
            print(error)
        }
        
        return postList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath)

        let post = posts[indexPath.row]
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.author

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let url = URL(string: post.link)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
