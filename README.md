# Baluchon

Baluchon est une application iOS contenant un convertisseur de devises, un traducteur et la météo.

## Architecture

Baluchon a été écrit sous Xcode en Swift 5 selon le pattern de conception MVC et supporte les iPhones en mode portrait à partir de iOS11

- Appels réseau avec URLSession
- Utilisation de PickerView, TextField, Stackview dans le StoryBoard avec AutoLayout.


### APIs

L'application utilise 3 API, créez un compte gratuit pour chaque service afin de récupérer vos clés

- Google Translate
https://cloud.google.com/translate/docs/

- Fixer.io
https://fixer.io/signup/free

- OpenWeatherMap
https://openweathermap.org/api

## installation

Après avoir téléchargé le projet, ouvrez Baluchon.xcodeproj

Créez un ficher .plist "ApiKeys" et créez les clés:
- "googleTranslateApiKey"
- "fixerApiKey"
- "openWeatherMapApiKey"

Complétez les valeurs avec vos clés API.


