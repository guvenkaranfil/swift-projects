//
//  ViewController.swift
//  Project7
//
//  Created by Güven Karanfil on 21.12.2020.
//  Copyright © 2020 Güven Karanfil. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var allPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action:
            #selector(refreshFilter))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filterPetitions(searchInput: answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func filterPetitions(searchInput: String){
        var filteredPetitions =  [Petition]()
        for petition in allPetitions {
            if petition.title.contains(searchInput) {
                filteredPetitions.append(petition)
            }
        }
        if !filteredPetitions.isEmpty {
            petitions = filteredPetitions
            tableView.reloadData()
        }
    }
    
    @objc func refreshFilter(){
        petitions = allPetitions
        tableView.reloadData()
    }
    
    @objc func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. please check your connectivity", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            allPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

