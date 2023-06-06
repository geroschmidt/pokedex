//
//  CeldaPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Geronimo Schmidt on 02/04/2023.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var nombrePokemon: UILabel!
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var buttonSegue: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagenPokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buttonSegueAction(_ sender: Any) {
        
        
    }
    
}
