# Popcorn
## Project sample app using TMdb API

### MVC-N Architecture:
Chose to use this type of architecture since there was only 1 main feature of the sample app. Was looking at using VIPER initially to use this as an opportunity to learn it, 
but I didn't feel the trade-off of modularizing a minimal set of features was necessary.

### Libraries Used
* Alamofire
* SwiftyJSON
* Kingfisher


### Disclaimer
One requirement was missing (`genre` on the Movie Detail view), as it is currently just a static placeholder label that says 'genre'
