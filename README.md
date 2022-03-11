# Pizza Configurator build with Flutter for Web (in progress)

A product configurator for configuring a pizza. 

## State Management

I thought about using either Bloc, Inherited Widget or flutter redux for the state management.

But since the Firebase is anyway needed later for Authentification, I use Firebase (Firestore) for state management in this app. 


## Packages Used (all with Null safety)

- flutter_launcher_icons

## Live Demos

- [Web](https://flutterwebapps.com/portfolio/pizza-configurator/#/)
- [Android] (https://play.google.com/store/apps/details?id=com.strawanzer.pizzaconfigurator)


## Documentation

### User flow

The app begins in `main.dart` with the `HomePage` widget. 
On clicking on the 'Start! button, the user is redirected to `Size` to configure the size of the pizza (small, medium or large).
After a size is chosen, the user gets redirected to `Sauce` to choose a sauce for the pizza (tomato sauce or tomato sauce spicy)
After the sauce is chosen, the user gets redirected to `Toppings` to choose one or several toppings to the pizza (Onions, Bacons etc).
After the toppings are chosen, the user gets redirected to a overview of the configured pizza.

After reading about the pizza, are you hungry yet? Behold, there is more to come!

### State Management

#### Navigating the Screens
The App beginns in `main.dart`. On click on the 'Start!' button, a pizza is initialized via the `createNewPizza()` method in `firestore_methods`. 
The pizza is a document with the fields 'size', 'sauce' and 'toppings'.
The id for the document is the `autoId` which is generated via a `DateTime.now().microsecondsSinceEpoch`. This `autoId` is used throuout the following steps.

After this initializing of the pizza, The 'Start!' button navigates to the next screen, the `Size`. `Size` takes the `autoId` as parameter.

`Size` is basically a `StreamBuilder` widget which gets the already generated pizza from the Firestore via the `_firebaseServices.getPizza()` method in `firestore_methods`. 
On click on one of the options, the pizza in the FireStore is updated via the `addOption()` method in `firestore_methods`.

The same flow applies also to the following `Sauce` and `Toppings` Widgets.

#### Order Progress among the Screens (order_progress.dart)
In the bottom of the Screens size, sauce and toppings is always the order process visible (items that the user has chosen). 
It's in the file `order_progress.dart`. 
This is a `StreamBuilder` which takes the `getPizza()` from `firestore_methods` as well.

## To Do Next

- [ ] Update Web App and Android version
- [ ] Full Documentation
- [ ] iOS Version