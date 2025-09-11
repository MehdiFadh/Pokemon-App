//
//  DocumentTableViewController.swift
//  Pokemon App
//
//  Created by Mehdi FADHLOUNE on 9/11/25.
//

import UIKit

class DocumentTableViewController: UITableViewController {
    var listeDresseur = [Dresseur]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTrainers()
        
    }

    // MARK: - Table view data source

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let regions = Set(listeDresseur.map { $0.region })
        return regions.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let region = regionForSection(section)
        return listeDresseur.filter { $0.region == region }.count
    }
    
    func regionForSection(_ section: Int) -> String {
        let regions = Array(Set(listeDresseur.map { $0.region })).sorted()
        return regions[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return regionForSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let region = regionForSection(indexPath.section)
        let dresseur = listeDresseur.filter { $0.region == region }[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        cell.textLabel?.text = dresseur.nom
        cell.imageView?.image = UIImage(named: dresseur.photo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = regionForSection(indexPath.section)
        let trainer = listeDresseur.filter { $0.region == region }[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DresseurDetailViewController") as! DresseurDetailViewController
        detailVC.trainer = trainer
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    func loadTrainers() {
            guard let url = Bundle.main.url(forResource: "dresseurs", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }

            do {
                listeDresseur = try JSONDecoder().decode([Dresseur].self, from: data)
                tableView.reloadData()
            } catch {
                print("Erreur de parsing JSON: \(error)")
            }
        }
    
    
}


extension [Pokemon] {
    func formattedNbPokemon() -> String {
        return "Nombre de pokémon : \(self)"
    }
}
