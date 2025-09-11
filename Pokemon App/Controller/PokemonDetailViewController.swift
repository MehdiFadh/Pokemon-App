//
//  PokemonDetailViewController.swift
//  Pokemon App
//
//  Created by Mehdi FADHLOUNE on 9/11/25.
//

import UIKit

// Contrôleur de vue qui affiche les détails d’un Pokémon sélectionné
class PokemonDetailViewController: UIViewController {
    
    // MARK: - Outlets (liens avec les éléments de l’interface Storyboard)
    
    @IBOutlet weak var pokemonDescriptionText: UITextView!   // Zone de texte affichant la description du Pokémon
    @IBOutlet weak var pokemonTypeLabel: UILabel!            // Label affichant le type du Pokémon
    @IBOutlet weak var pokemonImageView: UIImageView!        // Image du Pokémon
    @IBOutlet weak var pokemonNameLabel: UILabel!            // Nom du Pokémon
    
    // MARK: - Propriété de données
    
    var pokemon: Pokemon!   // Pokémon à afficher (doit être passé avant l'affichage de cette vue)
    
    // MARK: - Cycle de vie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Vérifie que l’objet Pokémon est bien initialisé avant d'essayer de l’utiliser
        if let pokemon = pokemon {
            
            // Affiche l'image du Pokémon ou une image par défaut si l'image n'existe pas
            pokemonImageView.image = UIImage(named: pokemon.image) ?? UIImage(systemName: "questionmark.circle")
            
            // Affiche le nom du Pokémon
            pokemonNameLabel.text = pokemon.nom
            
            // Affiche le type du Pokémon
            pokemonTypeLabel.text = "Type : \(pokemon.type)"
            
            // Affiche la description du Pokémon
            pokemonDescriptionText.text = pokemon.description
        }
    }
}
