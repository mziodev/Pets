# Project Notes


## Cannine Breed JSON list free IDs
- 94, 139, 178, 190


## Show users if they already are a Premium user


## Change Notes TextField to TextEditor


## Change Vaccines and Dewormings as info cards instead plain list elements


## Localization and i18n
- We have to do localization and internationalization of the entire app on: English, Spanish, French, Portuguese, German, Chinese, Japanese, Indian... on this order.


## iPad (waiting for iOS 18)
We have to adaptate the app to properly render on an iPad.


## Future features
### PDF export

### Food control:
- Food brand, quantity, cost, shop link.
- Food per day.

### Vaccines
- We need to store the cost? Or is included on the cost of consultation?

### Vet data
- Address, tel, link to the web...
- Cost: consultations, medicines...
- Historic of consultations.

### Incidences
- Injuries, vomits, small diarreas...

### Grooming

### Dead pets (archive pets)

### Coat size
- Coat type enum for future use:
```swift
enum PetSize: CaseIterable, Codable {
    case toy
    case mini
    case small
    case medium
    case large
    case extra
    case giant
    
    var name: String {
        switch self {
        case .toy:
            String(localized: "Toy")
        case .mini:
            String(localized: "Miniature")
        case .small:
            String(localized: "Small")
        case .medium:
            String(localized: "Medium")
        case .large:
            String(localized: "Large")
        case .extra:
            String(localized: "Extra Large")
        case .giant:
            String(localized: "Giant")
        }
    }
    
    var dogDescription: String {
        switch self {
        case .toy:
            String(localized: "Under 10 pounds (4.5 kg)")
        case .mini:
            String(localized: "10-20 pounds (4.5-9 kg)")
        case .small:
            String(localized: "20-30 pounds (9-13.6 kg)")
        case .medium:
            String(localized: "30-50 pounds (13.6-22.7 kg)")
        case .large:
            String(localized: "50-80 pounds (22.7-36 kg)")
        case .extra:
            String(localized: "80-100 pounds (36-45 kg)")
        case .giant:
            String(localized: "over 100 pounds (45 kg)")
        }
    }
    
    var catDescription: String {
        switch self {
        case .toy:
            String(localized: "under 4 pounds (1.8 kg)")
        case .mini:
            String(localized: "4-8 pounds (1.8-3.6 kg)")
        case .small:
            String(localized: "8-12 pounds (3.6-5.4 kg)")
        case .medium:
            String(localized: "12-15 pounds (5.4-6.8 kg)")
        case .large:
            String(localized: "15-18 pounds (6.8-8.2 kg)")
        case .extra:
            String(localized: "18-22 pounds (8.2-10 kg)")
        case .giant:
            String(localized: "over 22 pounds (10 kg)")
        }
    }
}
```

### Coat type
- Coat type enums for future use:
```swift
enum CoatLength: CaseIterable, Codable {
    case hairless
    case buzzed
    case fluffy
    case short
    case medium
    case long
    case flowing
    
    var name: String {
        switch self {
        case .hairless:
            String(localized: "Hairless")
        case .buzzed:
            String(localized: "Buzzed")
        case .fluffy:
            String(localized: "Fine downy coat")
        case .short:
            String(localized: "Short")
        case .medium:
            String(localized: "Medium")
        case .long:
            String(localized: "Long")
        case .flowing:
            String(localized: "Extra Long")
        }
    }
    
    var description: String {
        switch self {
        case .hairless:
            String(localized: "None (completely hairless)")
        case .buzzed:
            String(localized: "Very short (less than 1/4 inch or 6 mm)")
        case .fluffy:
            String(localized: "Fine downy coat (about 1/4 inch or 6 mm)")
        case .short:
            String(localized: "Less than 1 inch (2.5 cm)")
        case .medium:
            String(localized: "About 1-3 inches (2.5-7.5 cm)")
        case .long:
            String(localized: "About 3-6 inches (7.5-15 cm)")
        case .flowing:
            String(localized: "More than 6 inches (15 cm)")
        }
    }
}
```

```swift
enum CoatTexture: CaseIterable, Codable {
    case silky
    case medium
    case thick
    case wiry
    case crinkled
    
    var name: String {
        switch self {
        case .silky:
            String(localized: "Silky")
        case .medium:
            String(localized: "Medium")
        case .thick:
            String(localized: "Thick")
        case .wiry:
            String(localized: "Wiry")
        case .crinkled:
            String(localized: "Crinkle")
        }
    }
    
    var description: String {
        switch self {
        case .silky:
            String(localized: "Soft and smooth to the touch")
        case .medium:
            String(localized: "Straight and smooth, but not as fine as fine coats")
        case .thick:
            String(localized: "Thick and rough, with a dense undercoat")
        case .wiry:
            String(localized: "Harsh and wiry, with a dense undercoat")
        case .crinkled:
            String(localized: "Forms a wavy or crinkled texture")
        }
    }
}
```

```swift
enum CoatType: CaseIterable, Codable {
    case straight
    case curly
    case wavy
    case corded
    case double
    
    var name: String {
        switch self {
        case .straight:
            String(localized: "Straight")
        case .curly:
            String(localized: "Curly")
        case .wavy:
            String(localized: "Wavy")
        case .corded:
            String(localized: "Corded")
        case .double:
            String(localized: "Double")
        }
    }
    
    var description: String {
        switch self {
        case .straight:
            String(localized: "Lies flat against the body, with no curl or wave")
        case .curly:
            String(localized: "Forms tight curls or waves")
        case .wavy:
            String(localized: "Forms loose waves or ripples")
        case .corded:
            String(localized: "Forms long, thin cords or mats")
        case .double:
            String(localized: "Has two distinct layers of fur, with a soft undercoat and a coarser outer coat")
        }
    }
}
```

### Sharing data with other iCloud users
- It's not possible right now from SwiftData.
- Maybe it's possible merging SwiftData and CoreData.

