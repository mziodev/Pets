//
//  PetBreedDataService.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

class PetBreedDataService {

    static func loadPetBreeds(from filename: String) -> [PetBreed]? {
        
        let localeCode = Locale.current.language.languageCode?.identifier ?? "en"
        let localizedFilename = filename + "_\(localeCode)"
        
        if let url = Bundle.main.url(
            forResource: localizedFilename,
            withExtension: "json"
        ) {
            do {
                let data = try Data(contentsOf: url)
                let petBreeds = try JSONDecoder().decode(
                    [PetBreed].self,
                    from: data
                )
                
                return petBreeds
            } catch {
                print("Error loading JSON file: \(error)")
                
                return nil
            }
        } else {
            print("Can't find the file \(localizedFilename).json")
            
            return nil
        }
    }
}
