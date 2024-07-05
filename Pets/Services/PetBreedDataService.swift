//
//  PetBreedDataService.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

class PetBreedDataService {
    static func loadPetBreeds(from filename: String) -> [PetBreed]? {
            print("JSON file not found")
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let petBreeds = try jsonDecoder.decode([PetBreed].self, from: data)
                
                return petBreeds
            } catch {
                print("Error loading JSON file: \(error)")
                
                return nil
            }
        } else {
            
            return nil
        }
    }
}
