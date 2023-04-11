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
    @IBOutlet weak var textFieldBuscar: UITextField!
    
    //MARK: VARIABLES
    
    var pokemonArray: [Poke] = []
    var pokemonImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registrar nueva celda
        tableViewPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        textFieldBuscar.delegate = self
        tableViewPokemon.delegate = self
        tableViewPokemon.dataSource = self
       
        PokeProvider.shared.getAllPokemon { pokemon, images in
            
            // Asignar result success
            self.pokemonArray = pokemon
            self.pokemonImages = images.compactMap { $0 }
            
            // Refrezcar thread main
            DispatchQueue.main.async {
                self.tableViewPokemon.reloadData()
            }
        }
    }
    
    // MARK: IBACTIONS
    
    @IBAction func textFieldBuscarAction(_ sender: Any) {
        	
        
        textFieldBuscar.resignFirstResponder()
           
        
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
}

// MARK: FILTRADO BUSQUEDA

extension ViewController: UITextFieldDelegate {
        
}
