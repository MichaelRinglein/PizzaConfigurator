import 'package:flutter/material.dart';

class PizzaProvider extends ChangeNotifier {
  Map size = {};
  Map sauce = {};
  Map toppings = {};
  int indexToppings = 0;
  double priceToppings = 0.0;
  double totalPrice = 0.0;

  void addOptionToPizza(
    String part,
    String option,
    double optionCost,
    String image,
  ) {
    if (part == 'size') {
      size['text'] = option;
      size['cost'] = optionCost;
      size['image'] = image;
    } else if (part == 'sauce') {
      sauce['text'] = option;
      sauce['cost'] = optionCost;
      sauce['image'] = image;
    } else if (part == 'toppings') {
      if (!toppings.containsValue(option)) {
        toppings[option] = optionCost;
      }
    }

    for (var entry in toppings.entries) {
      priceToppings += entry.value;
    }

    totalPrice = size['cost'] + sauce['cost'] + priceToppings;
    //totalPrice = 20.0;
    print('toppings in Provider is $toppings');
    print('toppings.length is: ' + toppings.length.toString());
    notifyListeners();
  }

  void deleteToppings() {
    toppings = {};
    priceToppings = 0.0;
    notifyListeners();
  }
}
