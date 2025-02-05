//
//  VaccineType.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import Foundation

enum VaccineType: String, Codable, CaseIterable {
    case unknown
    case A
    case B
    case Ci
    case CoV
    case D
    case DHLPP
    case DHLPPi
    case DHPP
    case DHPPi
    case H
    case L
    case L4
    case L4R
    case Ly
    case P
    case Pi
    case R
    case FCV
    case FeLV
    case FIV
    case FPV
    case FVR
    case FVRCP
    case FVRCPHS = "FVRCP-HS"
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            String(localized: "Unknown")
        case .A:
            String(localized: "Adenovirus")
        case .B:
            String(localized: "Bordetella")
        case .Ci:
            String(localized: "Canine Influenza")
        case .CoV:
            String(localized: "Coronavirus")
        case .D:
            String(localized: "Distemper")
        case .DHLPP:
            String(localized: "Distemper, Hepatitis, Leptospirosis, Parvovirus and Parainfluenza")
        case .DHLPPi:
            String(localized: "Distemper, Hepatitis, Leptospirosis, Parvovirus, Parainfluenza and Influenza")
        case .DHPP:
            String(localized: "Distemper, Hepatitis, Parvovirus and Parainfluenza")
        case .DHPPi:
            String(localized: "Distemper, Hepatitis, Parvovirus, Parainfluenza and Influenza")
        case .H:
            String(localized: "Hepatitis")
        case .L4:
            String(localized: "Low risk Rabies")
        case .L4R:
            String(localized: "Live Rabies")
        case .L:
            String(localized: "Leptospirosis")
        case .Ly:
            String(localized: "Lyme disease")
        case .P:
            String(localized: "Parvovirus")
        case .Pi:
            String(localized: "Parainfluenza")
        case .R:
            String(localized: "Rabies")
        case .FCV:
            String(localized: "Calicivirus")
        case .FeLV:
            String(localized: "Leukemia Virus")
        case .FIV:
            String(localized: "Immunodeficiency Virus")
        case .FPV:
            String(localized: "Panleukopenia (also known as Feline Distemper)")
        case .FVR:
            String(localized: "Viral Rhinotracheitis")
        case .FVRCP:
            String(localized: "Feline Viral Rhinotracheitis, Calicivirus and Panleukopenia (also known as Feline Distemper)")
        case .FVRCPHS:
            String(localized: "Feline Viral Rhinotracheitis, Calicivirus, Panleukopenia (also known as Feline Distemper), Herpesvirus and Syncytial Virus")
        }
    }
    
    var species: String {
        switch self {
        case .unknown:
            "unknown"
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
        case .DHPP:
            "dogs"
        case .DHPPi:
            "dogs"
        case .DHLPP:
            "dogs"
        case .DHLPPi:
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
        case .FCV:
            "cats"
        case .FeLV:
            "cats"
        case .FIV:
            "cats"
        case .FPV:
            "cats"
        case .FVR:
            "cats"
        case .FVRCP:
            "cats"
        case .FVRCPHS:
            "cats"
        }
    }
}
