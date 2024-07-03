# Project Notes

## Resizable image
We need to implement a resizable function for pet images. Probably we need a new intermediate sheet view for selecting and resizing the photo. And it would be a good idea an alert message before deleting the existing image.


## Pet icon color
Maybe we can try to color dog and cat icons differently no the main pet list.


## Localization and i18n
We have to do localization an internationalization of the entire app: English, Spanish, French, Portuguese, German, Chinese, Japanese, Indian... on this order. 
* Checkout: Text messages from alerts and empty views


<!--## Trim spaces
We need to trim all final and first blank spaces before save on the data base.-->


## Chip ID Types
There are three main formats for pet microchip IDs:
* 9-digit code: This is an older format, typically used by AVID (American Veterinary Identification Devices) microchips. The 9-digit code is numeric only and doesn't include a checksum.
* 10-digit code: This is the most widely used format, compliant with the ISO 11784 standard. It's a 10-digit alphanumeric code, with the first three digits representing the country code or manufacturer code, followed by a unique identifier, and ending with a two-digit checksum.
* 15-digit code: This is a newer format, used by some microchip manufacturers, such as ISO-compliant microchips from companies like Datamars or Trovan. The 15-digit code is also alphanumeric and includes a longer unique identifier and a checksum.
