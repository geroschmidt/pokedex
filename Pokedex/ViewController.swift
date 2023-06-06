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
    
    @IBOutlet weak var tableViewPokemon: UITableView!
    
    //MARK: VARIABLES
    
    var pokemonArray: [Poke] = []
    var secondaryPokemonArray: [Poke] = []
    var pokemonImages = [UIImage]()
    var secondaryPokemonImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            pokemonArray = searchText.isEmpty ? secondaryPokemonArray :
            secondaryPokemonArray.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
                tableViewPokemon.reloadData()
            }
    }
    
    
}

// MARK: TABLA

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableViewPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        // Mostrar datos
        
        celda.nombrePokemon.text = pokemonArray[indexPath.row].name
        celda.imagenPokemon.image = pokemonImages[indexPath.row]
        
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let senderData = (name: pokemonArray[indexPath.row].name, image: pokemonImages[indexPath.row])
        
        let viewController = ViewControllerPokemon()
        
        viewController.input = PokemonSelected(imagenPokemon: pokemonImages[indexPath.row], nombrePokemon: pokemonArray[indexPath.row].name)
        
        navigationController?.pushViewController(viewController, animated: true)
        
        

        //performSegue(withIdentifier: "infoSegue", sender: senderData)
    }
}

// MARK: FILTRADO BUSQUEDA

extension ViewController: UITextFieldDelegate {
        
}

extension UIStoryboard {
  static func instantiate(viewController viewControllerName: String) -> UIViewController {
    return UIStoryboard(name: viewControllerName, bundle: .main).instantiateViewController(withIdentifier: viewControllerName)
  }
}
