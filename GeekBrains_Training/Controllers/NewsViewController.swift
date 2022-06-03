//
//  NewsViewController.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 10.05.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //let refreshControl = UIRefreshControl()
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    
    let networksManager = NewsNetworkManager()
    
    var news: News = News(totalResults: Int(), articles: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 500
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        
//        refreshControl.tintColor = UIColor.blue
//        tableView.addSubview(refreshControl)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews(_sender:)), for: .valueChanged)
        
        
//        refreshControl.addTarget(self, action: #selector(refreshNews(_sender:)), for: .valueChanged)
        
        networksManager.news() { (news) in
            self.news = news
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func refreshNews(_sender: Any) {
        networksManager.news() { (news) in
            self.news = news
            DispatchQueue.main.asyncAfter(deadline: .now()+20) {
                self.tableView.reloadData()
            }
        }
        tableView.refreshControl?.endRefreshing()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        cell.configure(news: news.articles[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toFriendProfile", sender: friendsArray[indexPath.row])
//    }
}
