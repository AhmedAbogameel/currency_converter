## - Instructions on how to build the project.

- Dismantling project into features
- Project structure
- Take a look at Design on XD / Figma (in this case i have drawn it on paper)
- Start designing the feature CurrencyConverter
- Build Entities through this feature
- then build use cases
- then repositories
- finally data sources
- Write tests for this uncoupled abstracted classes
- implement abstracted classes
- test our unit tests
- refactor implemented classes then run tests again

## Adapted design pattern for the app architecture

### Repository

I have adapted this pattern because our app uses different data sources
so this pattern helped me a lot to control data through these data source (local/remote)

## Adapted image loader library 

### Lottie 
their website includes various, simple and awesome animations 
the package is easy to use and make custom animations;

## Used database in the app

### GetStorage
as this database is no sql and faster one faster than sqflite and sharedpreferences
and our app is not depend on huge local database so i think no sql database suitable for this scale.