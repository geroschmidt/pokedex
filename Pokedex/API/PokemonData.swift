//
//  Data.swift
//  Pokedex
//
//  Created by Geronimo Schmidt on 02/04/2023.
//

import Foundation
import Alamofire

// MARK: - PokeResponse
 struct PokeResponse: Codable {
    let count: Int
    let next: String
    let results: [Poke]
}


// MARK: - Poke
struct Poke: Codable {
    let name: String
    let url: String 
}
