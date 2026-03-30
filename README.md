# 📱 Pokemon App

Une application iOS développée en Swift permettant de gérer une collection de dresseurs Pokémon, leurs badges et leurs Pokémon. L'utilisateur peut consulter les détails, ajouter de nouveaux dresseurs, et visualiser les informations dans une interface organisée par région.

---

## 🧠 Fonctionnalités

- 📂 Chargement des données depuis un fichier JSON local (`dresseurs.json`)
- 🧑‍💼 Affichage d'une liste de dresseurs groupés par région
- 🔍 Détail d’un dresseur : badges, photo, Pokémon
- ➕ Ajout de nouveaux dresseurs via un formulaire
- 📸 Intégration de l’image via la bibliothèque photo
- 💾 Sauvegarde locale des données dans le dossier Documents
- 👁️‍🗨️ Aperçu de la photo du dresseur en plein écran via QuickLook

---

## 🏗️ Architecture

Le projet est structuré autour de plusieurs ViewControllers principaux :

### `DocumentTableViewController.swift`
- Affiche la liste des dresseurs groupés par région
- Charge les données JSON depuis le bundle ou le dossier Documents
- Permet d’ajouter de nouveaux dresseurs

### `DresseurDetailViewController.swift`
- Affiche les informations détaillées d’un dresseur
- Liste ses badges et Pokémon
- Permet d’afficher l’image du dresseur en plein écran avec un QLPreview

### `PokemonDetailViewController.swift`
- Affiche les détails d’un Pokémon sélectionné (image, type, description)

### `AjoutDresseurViewController.swift`
- Formulaire d’ajout d’un nouveau dresseur
- Parsing manuel de l’entrée utilisateur pour créer des objets `Dresseur`, `Badge`, et `Pokemon`

---

## 🖼️ Captures d'écran

Voici quelques captures d'écran de l'application :

<p align="center">
  <img src="Pokemon%20App/Resources/Assets/Capture%20d’écran%202026-03-17%20à%2021.21.35.png" width="30%" />
  <img src="Pokemon%20App/Resources/Assets/Capture%20d’écran%202026-03-17%20à%2021.21.45.png" width="30%" />
  <img src="Pokemon%20App/Resources/Assets/Capture%20d’écran%202026-03-17%20à%2021.21.52.png" width="30%" />
</p>

---

## 🗂️ Modèles

Les entités manipulées incluent :

- `Dresseur` : nom, région, photo, badges, pokémons
- `Badge` : nom, image
- `Pokemon` : nom, type, image, description

Le fichier JSON (`dresseurs.json`) suit une structure comme celle-ci :

```json
[
  {
    "nom": "Sacha",
    "region": "Kanto",
    "photo": "sacha.png",
    "badges": [
      { "nom": "Roche", "image": "badge_roche.png" }
    ],
    "pokemons": [
      {
        "nom": "Pikachu",
        "image": "pikachu.png",
        "type": "Électrik",
        "description": "Un Pokémon souris de type électrique."
      }
    ]
  }
]

