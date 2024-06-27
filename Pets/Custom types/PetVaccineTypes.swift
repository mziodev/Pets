//
//  PetVaccineTypes.swift
//  Pets
//
//  Created by MZiO on 27/6/24.
//

import Foundation

enum CanineVaccines: String, Codable {
    case A
    case B
    case Ci
    case CoV
    case D
    case H
    case L
    case Ly
    case P
    case Pi
    case R
    
    var description: String {
        switch self {
        case .A:
            "Adenovirus"
        case .B:
            "Bordetella"
        case .Ci:
            "Canine influenza"
        case .CoV:
            "Coronavirus"
        case .D:
            "Distemper"
        case .H:
            "Hepatitis"
        case .L:
            "Leptospirosis"
        case .Ly:
            "Lyme disease"
        case .P:
            "Parvovirus"
        case .Pi:
            "Parainfluenza"
        case .R:
            "Rabies"
        }
    }
}

enum CanineCombinationVaccines: String, Codable {
    case DHPP
    case DHPPi
    case DHLPP
    case DHLPPi
    case L4
    case L4R
    
    var description: String {
        switch self {
        case .DHPP:
            "Distemper, Hepatitis, Parvovirus, Parainfluenza"
        case .DHPPi:
            "Distemper, Hepatitis, Parvovirus, Parainfluenza and Influenza"
        case .DHLPP:
            "Distemper, Hepatitis, Leptospirosis, Parvovirus and Parainfluenza"
        case .DHLPPi:
            "Distemper, Hepatitis, Leptospirosis, Parvovirus, Parainfluenza and Influenza"
        case .L4:
            "Low risk Rabies"
        case .L4R:
            "Live for Rabies"
        }
    }
}

enum FelineVaccines: String, Codable {
    case FVR
    case FCV
    case FPV
    case FeLV
    case FIV
    
    var description: String {
        switch self {
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

enum FelineCombinationVaccines: String, Codable {
    case FVRCP
    case FVRCPHS = "FVRCP-HS"
    
    var description: String {
        switch self {
        case .FVRCP:
            "Feline Viral Rhinotracheitis, Calcivirus, Paleukopenia (also known as Feline Distemper)."
        case .FVRCPHS:
            "Feline Viral Rhinotracheitis, Calcivirus, Paleukopenia (also known as Feline Distemper), Herpesvirus and Syncytial Virus."
        }
    }
}
