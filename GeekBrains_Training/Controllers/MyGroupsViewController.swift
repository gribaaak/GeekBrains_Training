//
//  MyGroupsViewController.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 31.10.2021.
//

import UIKit

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myGroupsArray = [Group]()
    
    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AllGroupsViewController,
        let index = sourceVC.tableView.indexPathForSelectedRow {
            let group = sourceVC.allGroups[index.row]
            if !myGroupsArray.contains(where: {$0.title == group.title}){
                myGroupsArray.append(group)
            }
            tableView.reloadData()
        }
    }
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: myGroupsArray[indexPath.row])
        return cell
    }
}
