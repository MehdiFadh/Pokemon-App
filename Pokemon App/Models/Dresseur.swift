
struct Trainer: Codable {
    let name: String
    let region: String
    let photo: String
    let badges: [Badge]
    let pokemons: [Pokemon]
}
