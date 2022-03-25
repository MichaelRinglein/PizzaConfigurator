# Pizza Configurator build with Flutter for Web (in progress)

A product configurator for configuring a pizza. 

## State Management

~I thought about using either Bloc, Inherited Widget or flutter redux for the state management.~

~But since the Firebase is anyway needed later for Authentification, I use Firebase (Firestore) for state management in this app. ~

Using `Firebase` and it snapshots as state management solution did work in general for simple single strings and lists. 
But I quickly reached the limitations of feasability due to the not-unified and nested lists/maps in this app (especially with the toppings for the pizza).
Thus I decided to go for the `Provider` to manage the state instead, as I already did in other apps.


## Packages Used (all with Null safety)

- provider
- intl
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

### Order Progress among the Screens (order_progress.dart)
In the bottom of the Screens size, sauce and toppings is always the order process visible (items that the user has chosen). 
It's in the file `order_progress.dart`. 

## To Do Next

- [x] Update Web App and Android version
- [ ] Full Documentation
- [ ] iOS Version