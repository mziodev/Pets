//
//  PetBreedDataService.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

class PetBreedDataService {
    
    static func loadPetBreeds(from filename: String) -> [PetBreed]? {
        
        let localizedFilename = filename + "_\(Locale.current.language.languageCode?.identifier ?? "en")"
        
        if let url = Bundle.main.url(
            forResource: localizedFilename,
            withExtension: "json"
        ) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let petBreeds = try jsonDecoder.decode([PetBreed].self, from: data)
                
                return petBreeds
            } catch {
                print("Error loading JSON file: \(error)")
                // TODO: show user about this error
                
                return nil
            }
        } else {
            print("Can't find file \(localizedFilename).json")
            // TODO: show user about this error
            
            return nil
        }
    }
}
