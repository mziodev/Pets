//
//  FelineVaccineType.swift
//  Pets
//
//  Created by MZiO on 27/6/24.
//

import Foundation

enum FelineVaccineType: String, Codable {
    case FVRCP
    case FVRCPHS = "FVRCP-HS"
    case FVR
    case FCV
    case FPV
    case FeLV
    case FIV
    
    var description: String {
        switch self {
        case .FVRCP:
            "Feline Viral Rhinotracheitis, Calcivirus, Paleukopenia (also known as Feline Distemper)."
        case .FVRCPHS:
            "Feline Viral Rhinotracheitis, Calcivirus, Paleukopenia (also known as Feline Distemper), Herpesvirus and Syncytial Virus."
        case .FVR:
            "Viral Rhinotracheitis"
        case .FCV:
            "Calicivirus"
        case .FPV:
            "Panleukopenia (also known as Feline Distemper)"
        case .FeLV:
            "Leukemia Virus"
        case .FIV:
            "Immunodeficiency Virus"
        }
    }
}
