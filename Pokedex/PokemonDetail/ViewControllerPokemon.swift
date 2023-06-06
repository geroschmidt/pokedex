//
//  ViewControllerPokemon.swift
//  Pokedex
//
//  Created by Geronimo Schmidt on 11/04/2023.
//

import UIKit

class ViewControllerPokemon: UIViewController {

    
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var nombrePokemon: UILabel!
    
    public var input: PokemonSelected!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //imagenPokemon.image = input.imagenPokemon
        //nombrePokemon.text = input.nombrePokemon
        
    }

}
