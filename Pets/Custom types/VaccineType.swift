//
//  VaccineType.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import Foundation

enum VaccineType: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    
    case unknown = "Unknown"
    case DHPP
    case DHPPi
    case DHLPP
    case DHLPPi
    case L4
    case L4R
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
    case FVRCP
    case FVRCPHS = "FVRCP-HS"
    case FVR
    case FCV
    case FPV
    case FeLV
    case FIV
    
    var description: String {
        switch self {
        case .unknown:
            ""
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
            "Live Rabies"
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
    
    var species: String {
        switch self {
        case .unknown:
            ""
        case .DHPP:
            "dogs"
        case .DHPPi:
            "dogs"
        case .DHLPP:
            "dogs"
        case .DHLPPi:
            "dogs"
        case .L4:
            "dogs"
        case .L4R:
            "dogs"
        case .A:
            "dogs"
        case .B:
            "dogs"
        case .Ci:
            "dogs"
        case .CoV:
            "dogs"
        case .D:
            "dogs"
        case .H:
            "dogs"
        case .L:
            "dogs"
        case .Ly:
            "dogs"
        case .P:
            "dogs"
        case .Pi:
            "dogs"
        case .R:
            "dogs"
        case .FVRCP:
            "cats"
        case .FVRCPHS:
            "cats"
        case .FVR:
            "cats"
        case .FCV:
            "cats"
        case .FPV:
            "cats"
        case .FeLV:
            "cats"
        case .FIV:
            "cats"
        }
    }
}
