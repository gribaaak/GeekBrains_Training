//
//  AllGroupsViewController.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 31.10.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    
    var allGroups = [
        Group(title: "Application ideas", avatar: UIImage(named: "Application ideas")!),
        Group(title: "Intertainment", avatar: UIImage(named: "Intertainment")!),
        Group(title: "Learning GB", avatar: UIImage(named: "Learning GB")!),
        Group(title: "Places to travel", avatar: UIImage(named: "Places to travel")!),
        Group(title: "Politics", avatar: UIImage(named: "Politics")!),
        Group(title: "Work", avatar: UIImage(named: "Work")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: allGroups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "backToMyGroups", sender: self)
    }
}
