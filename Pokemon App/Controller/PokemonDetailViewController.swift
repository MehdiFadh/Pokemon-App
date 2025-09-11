//
//  PokemonDetailViewController.swift
//  Pokemon App
//
//  Created by Mehdi FADHLOUNE on 9/11/25.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonDescriptionText: UITextView!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Affichage des informations du Pokémon
        if let pokemon = pokemon {
            pokemonImageView.image = UIImage(named: pokemon.image) ?? UIImage(systemName: "questionmark.circle")
            pokemonNameLabel.text = pokemon.nom
            pokemonTypeLabel.text = "Type: \(pokemon.type)"
            pokemonDescriptionText.text = pokemon.description
        }
        
    }

}
