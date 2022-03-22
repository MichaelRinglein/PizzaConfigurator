import 'package:flutter/material.dart';

class PizzaProvider extends ChangeNotifier {
  Map size = {};
  Map sauce = {};
  Map toppings = {};
  int indexToppings = 0;
  double priceToppings = 0.0;
  Map totalPrice = {};

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
      totalPrice['costSize'] = optionCost;
    } else if (part == 'sauce') {
      sauce['text'] = option;
      sauce['cost'] = optionCost;
      sauce['image'] = image;
      totalPrice['costSauce'] = optionCost;
    } else if (part == 'toppings') {
      if (!toppings.containsKey(option)) {
        toppings[option] = optionCost;
      }
    }

    //get the price from the toppings map
    priceToppings = 0.0;
    for (var entry in toppings.entries) {
      priceToppings += entry.value;
    }
    totalPrice['costToppings'] = priceToppings;

    notifyListeners();
  }

  void deleteToppings() {
    toppings = {};
    priceToppings = 0.0;
    notifyListeners();
  }
}
