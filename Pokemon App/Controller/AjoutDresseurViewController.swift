//
//  AjoutDresseurViewController.swift
//  Pokemon App
//
//  Created by Mehdi FADHLOUNE on 9/11/25.
//

import UIKit

class AjoutDresseurViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemonsTextField: UITextField!
    @IBOutlet weak var badgesTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    
    
    
    var imageName: String?
    var onDresseurAjoute: ((Dresseur) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        nomTextField.delegate = self
        pokemonsTextField.delegate = self
        badgesTextField.delegate = self
        regionTextField.delegate = self
        
    }
    
    @IBAction func choisirImageTapped(_ sender: UIButton) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                imageView.image = image
                imageName = UUID().uuidString + ".png"
                
                if let data = image.pngData() {
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let imageURL = documentsDirectory.appendingPathComponent(imageName!)
                    try? data.write(to: imageURL)
                }

            }
            picker.dismiss(animated: true)
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Ferme le clavier
        return true
    }

    
    @IBAction func ajouterTapped(_ sender: UIButton) {
        // Vérification que tous les champs sont remplis
        guard let nom = nomTextField.text, !nom.isEmpty,
              let region = regionTextField.text, !region.isEmpty,
              let badgesString = badgesTextField.text, !badgesString.isEmpty,
              let pokemonsString = pokemonsTextField.text, !pokemonsString.isEmpty else {
            showAlert(title: "Erreur", message: "Veuillez remplir tous les champs.")
            return
        }

        // Conversion des badges (ex: "Feu,Eau" → [Badge(nom: "Feu"), Badge(nom: "Eau")])
        let badges: [Badge] = badgesString.split(separator: ",").map {
            Badge(nom: String($0).trimmingCharacters(in: .whitespaces), image: "\(nom).png")
        }

        // Conversion des pokémons (ex: "Pikachu : Electrik / Petit souris; Dracaufeu : Feu / Grand lézard")
        let pokemons: [Pokemon] = pokemonsString.split(separator: ";").compactMap { entry in
            let trimmedEntry = entry.trimmingCharacters(in: .whitespaces)
            guard !trimmedEntry.isEmpty else { return nil }

            // Découper par ":"
            let parts = trimmedEntry.split(separator: ":", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
            guard parts.count == 2 else {
                print("❌ Mauvais format de pokémon : \(entry)")
                return nil
            }

            let nomPokemon = parts[0]

            // Dans la partie droite, séparer Type / Description
            let typeDesc = parts[1].split(separator: "/", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
            guard typeDesc.count == 2 else {
                print("❌ Mauvais format type/description : \(parts[1])")
                return nil
            }

            let type = typeDesc[0]
            let description = typeDesc[1]

            return Pokemon(
                nom: nomPokemon,
                image: "\(nomPokemon).png", // génère automatiquement le nom de l’image
                type: type,
                description: description
            )
        }

        // Création du nouveau dresseur
        let nouveauDresseur = Dresseur(
            nom: nom,
            region: region,
            photo: imageName ?? "defaultDresseur.png",
            badges: badges,
            pokemons: pokemons
        )

        // 🔁 Ajout dans la liste via une closure
        onDresseurAjoute?(nouveauDresseur)

        // Optionnel : Enregistrer dans le fichier JSON
        sauvegarderDresseur(nouveauDresseur)

        // Retour à la vue précédente
        navigationController?.popViewController(animated: true)
    }

    
    func sauvegarderDresseur(_ dresseur: Dresseur) {
        guard let url = Bundle.main.url(forResource: "dresseurs", withExtension: "json") else {
            print("❌ Impossible de trouver le fichier dresseurs.json")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            var dresseurs = try JSONDecoder().decode([Dresseur].self, from: data)
            dresseurs.append(dresseur)

            let updatedData = try JSONEncoder().encode(dresseurs)
            
            // ⚠️ Impossible d'écrire dans le bundle → copier dans le Documents directory d'abord
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectory.appendingPathComponent("dresseurs.json")
            try updatedData.write(to: destinationURL)
            
            print("✅ Dresseur sauvegardé dans \(destinationURL.path)")
        } catch {
            print("❌ Erreur lors de la sauvegarde : \(error)")
        }
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }



}
