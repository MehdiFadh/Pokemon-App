// // DresseurDetailViewController.swift // Pokemon App // // Created by Mehdi FADHLOUNE on 9/11/25. //

import UIKit

// Contrôleur de vue qui affiche les détails d'un dresseur, y compris ses badges et ses Pokémon
class DresseurDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nomLabel: UILabel!        // Affiche le nom du dresseur
    @IBOutlet weak var tableView: UITableView!   // TableView listant les Pokémon du dresseur
    @IBOutlet weak var badgesLabel: UILabel!     // Affiche les badges du dresseur
    @IBOutlet weak var imageView: UIImageView!   // Affiche la photo du dresseur

    // MARK: - Données
    
    var dresseur: Dresseur!   // Le dresseur à afficher (doit être défini avant l'affichage)
    
    // MARK: - Cycle de vie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure l'interface avec les données du dresseur
        imageView.image = UIImage(named: dresseur.photo)
        nomLabel.text = dresseur.nom
        badgesLabel.text = "Badge(s) : \(dresseur.badges.map { $0.nom }.joined(separator: ", "))"
        
        // Enregistre une cellule standard pour la tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
        // Définit les delegates pour gérer l'affichage et l'interaction avec la tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
}



// Extension du contrôleur pour gérer les données et interactions de la tableView
extension DresseurDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Retourne le nombre de Pokémon à afficher dans la table (autant de lignes que de Pokémon)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dresseur.pokemons.count
    }
    
    // Configure et retourne chaque cellule de la table pour un Pokémon donné
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = dresseur.pokemons[indexPath.row]
        
        // Affiche l'image du Pokémon ou une icône par défaut si l'image est absente
        cell.imageView?.image = UIImage(named: pokemon.image) ?? UIImage(systemName: "bolt.circle")
        
        // Affiche le nom et le type du Pokémon
        cell.textLabel?.text = "\(pokemon.nom) - \(pokemon.type)"
        
        return cell
    }
    
    // Gère l’action lorsqu’un utilisateur sélectionne un Pokémon dans la liste
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Désélectionne la cellule après le clic pour l'effet visuel
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Récupère le Pokémon sélectionné
        let pokemon = dresseur.pokemons[indexPath.row]
        
        // Lance la transition vers la vue détail du Pokémon en passant l'objet sélectionné
        performSegue(withIdentifier: "showPokemonDetail", sender: pokemon)
    }
    
    // Prépare la vue de destination avant la navigation (segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Vérifie que la destination est bien le contrôleur de détail de Pokémon
        if let destinationVC = segue.destination as? PokemonDetailViewController {
            // Vérifie que l'objet envoyé est un Pokémon
            if let pokemon = sender as? Pokemon {
                // Transmet le Pokémon sélectionné à la vue de détail
                destinationVC.pokemon = pokemon
            }
        }
    }
}
