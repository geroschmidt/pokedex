//
//  PokeProvider .swift
//  Pokedex
//
//  Created by Geronimo Schmidt on 02/04/2023.
//

import Foundation
import Alamofire

final class PokeProvider {
    
    static let shared = PokeProvider()
    
    private let kBaseUrl = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151"
    
    private let kStatusOk = 200...299
    
    func getAllPokemon(success: @escaping(_ pokemon: [Poke], _ images: [UIImage?]) -> ()) {
        AF.request(kBaseUrl, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: PokeResponse.self) { response in
            if let pokeResponse = response.value {
                let pokemon = pokeResponse.results
                var images = [UIImage?](repeating: nil, count: pokemon.count)
                let dispatchGroup = DispatchGroup()
                
                for (index, poke) in pokemon.enumerated() {
                    dispatchGroup.enter()
                    AF.request(poke.url, method: .get).validate(statusCode: self.kStatusOk).responseJSON { response in
                        if let json = response.value as? [String: Any], let sprites = json["sprites"] as? [String: Any], let frontDefaultUrlString = sprites["front_default"] as? String, let frontDefaultUrl = URL(string: frontDefaultUrlString) {
                            AF.download(frontDefaultUrl).responseData { response in
                                if let data = response.value, let image = UIImage(data: data) {
                                    images[index] = image
                                    dispatchGroup.leave()
                                }
                            }
                        } else {
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    success(pokemon, images)
                }
            } else {
                print(response.error?.errorDescription ?? "No error")
            }
        }
    }
}
