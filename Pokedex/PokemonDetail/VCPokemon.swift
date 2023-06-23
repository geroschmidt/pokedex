

import Foundation
import UIKit

class VCPokemon: UIViewController {

    
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var nombrePokemon: UILabel!
    
   
    
    public var input: PokemonSelected!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            imgPokemon.image = input.imagenPokemon
            nombrePokemon.text = input.nombrePokemon
    }

}
