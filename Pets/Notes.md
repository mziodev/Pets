# Project Notes

## Color Code
### Old
- Accent Red: #E15161
- Accent Blue: #00A5E0

## Cannine Breed JSON list free IDs
- 94, 139, 178, 190


## Notifications
- We have to remove an existing notification when updating a vaccine or treatment for avoiding duplicates.
- We need to pass an existing ID (ex. vaccine.id) and check if this ID is already inside NotificationCenter. If so we remove it and create a new one with the new data.


## Localization and i18n
- We have to do localization and internationalization of the entire app on: English, Spanish, French, Portuguese, German, Chinese, Japanese, Indian... on this order.


## Resizable image
We need to implement a resizable function for pet images. Probably we need a new intermediate sheet view for selecting and resizing the photo. And it would be a good idea an alert message before deleting the existing image.


## Sharing data with other iCloud users
- It's not possible right now from SwiftData.
- Maybe it's possible merging SwiftData and CoreData.


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

### Dead pets (archived)

