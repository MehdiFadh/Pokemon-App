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
        
        // Chargement des dresseurs depuis un fichier JSON lors du chargement initial de la vue
        loadTrainers()
    }

    // MARK: - Table view data source

    // Retourne le nombre de sections dans la table, basé sur le nombre de régions uniques
    override func numberOfSections(in tableView: UITableView) -> Int {
        let regions = Set(listeDresseur.map { $0.region })
        return regions.count
    }
    
    // Retourne le nombre de lignes (dresseurs) dans une section spécifique (région)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let region = regionForSection(section)
        return listeDresseur.filter { $0.region == region }.count
    }
    
    // Retourne le nom de la région correspondant à une section donnée (utilisée pour l'en-tête et le filtrage)
    func regionForSection(_ section: Int) -> String {
        let regions = Array(Set(listeDresseur.map { $0.region })).sorted()
        return regions[section]
    }
    
    // Retourne le titre de l'en-tête de section (le nom de la région)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return regionForSection(section)
    }
    
    // Configure et retourne la cellule pour une ligne donnée dans une section (affiche nom, badges, photo)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let region = regionForSection(indexPath.section)
        let dresseur = listeDresseur.filter { $0.region == region }[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        cell.textLabel?.text = dresseur.nom
        cell.detailTextLabel?.text = dresseur.badges.formattedBadge()
        cell.imageView?.image = UIImage(named: dresseur.photo)
        
        return cell
    }
    
    // Prépare la transition vers le détail d'un dresseur en transmettant l'objet sélectionné
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DresseurDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let region = regionForSection(indexPath.section)
                let dresseursInRegion = listeDresseur.filter { $0.region == region }
                let dresseur = dresseursInRegion[indexPath.row]
                
                destinationVC.dresseur = dresseur
            }
        }
    }

    // Charge les dresseurs à partir du fichier JSON et met à jour la table view
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


// Extension pour le tableau de Pokémon : formate un affichage du nombre de Pokémon
extension [Pokemon] {
    func formattedNbPokemon() -> String {
        return "Nombre de pokémon : \(self)"
    }
}

// Extension pour le tableau de Badges : formate un affichage lisible des badges
extension [Badge] {
    func formattedBadge() -> String {
        let badgeNames = self.map { $0.nom }
        return "Badge(s) : \(badgeNames.joined(separator: ", "))"
    }
}
