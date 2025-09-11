// // DresseurDetailViewController.swift // Pokemon App // // Created by Mehdi FADHLOUNE on 9/11/25. //

import UIKit

class DresseurDetailViewController: UIViewController {
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var badgesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var dresseur: Dresseur!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: dresseur.photo)
        nomLabel.text = dresseur.nom
        badgesLabel.text = "Badge(s) : \(dresseur.badges.map { $0.nom }.joined(separator: ", "))"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
}


extension DresseurDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dresseur.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = dresseur.pokemons[indexPath.row]
        cell.imageView?.image = UIImage(named: pokemon.image) ?? UIImage(systemName: "bolt.circle")
        cell.textLabel?.text = "\(pokemon.nom) - \(pokemon.type)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pokemon = dresseur.pokemons[indexPath.row]
        performSegue(withIdentifier: "showPokemonDetail", sender: pokemon)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PokemonDetailViewController {
            if let pokemon = sender as? Pokemon {
                destinationVC.pokemon = pokemon
            }
        }
    }

        
    
}
