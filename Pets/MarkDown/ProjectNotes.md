# Project Notes

## Edit view issue
We need to separate detail views from edit views. Right now we have mixed these two views: the detail view is the same as the edit view. This kind of approach is problematic because users won't understand when to edit or not.

## Pet chip ID
We need to implement a separate structure for this piece of data:
* Chip ID number
* Implanted Date
* Location (inside the animal)

We can implement a link to [PETMAXX](https://www.petmaxx.com) directly from Chip ID number.

## Vaccine view
Each pet species need a separate vaccine model. This is because vaccine types: canine and feline types are different so models need to be different too. It seems to be the simplest way to do it. 

