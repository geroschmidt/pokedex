//
//  ViewController.swift
//  Pokedex
//
//  Created by Geronimo Schmidt on 02/04/2023.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    
    //MARK: IBOULETS
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewPokemon: UITableView!
    
    //MARK: VARIABLES
    
    var pokemonArray: [Poke] = []
    var secondaryPokemonArray: [Poke] = []
    var pokemonImages = [UIImage]()
    var secondaryPokemonImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
        
        // Registrar nueva celda
        tableViewPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        tableViewPokemon.delegate = self
        tableViewPokemon.dataSource = self
       
        PokeProvider.shared.getAllPokemon { [self] pokemon, images in
            // Asignar result success
            self.pokemonArray = pokemon
            self.pokemonImages = images.compactMap { $0 }
            self.secondaryPokemonArray = self.pokemonArray
            self.secondaryPokemonImages = self.pokemonImages
            // Refrezcar thread main
            DispatchQueue.main.async {
                self.tableViewPokemon.reloadData()
            }
        }
    }
    
    // MARK: IBACTIONS
    
    @IBAction func SearchHundler(_ sender: UITextField) {
        
        if let searchText = sender.text {
            if searchText.isEmpty {
                //si esta vacio muestro el array completo
                pokemonArray = secondaryPokemonArray
                pokemonImages = secondaryPokemonImages
            } else {
                //si no filtro por nombre
                //enumerated obtengo el indice
                let filteredPokemons = secondaryPokemonArray.enumerated().filter { index, pokemon in
                    return pokemon.name.lowercased().contains(searchText.lowercased())
                }
                pokemonArray = filteredPokemons.map { $0.element }
                pokemonImages = filteredPokemons.map { secondaryPokemonImages[$0.offset] }
            }
            tableViewPokemon.reloadData()
        }
    }
    
    
}

// MARK: Extensions

//Table

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableViewPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        // Mostrar datos
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
        celda.nombrePokemon.text = pokemonArray[indexPath.row].name
        celda.imagenPokemon.image = pokemonImages[indexPath.row]
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemonName = pokemonArray[indexPath.row].name
        let selectedPokemonImage = pokemonImages[indexPath.row]
        
        let pokemonSelected = PokemonSelected(imagenPokemon: selectedPokemonImage, nombrePokemon: selectedPokemonName)
        
        performSegue(withIdentifier: "pokemonSegue", sender: pokemonSelected)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonSegue" {
            if let destinationVC = segue.destination as? VCPokemon,
               let pokemonData = sender as? PokemonSelected {
                destinationVC.input = pokemonData
            }
        }
    }


}


