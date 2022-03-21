import 'package:flutter/material.dart';

class PizzaProvider extends ChangeNotifier {
  /*
  List availableOptions = [
    {
      'size': {
        {
          'text': 'Small (25cm)',
          'cost': 2.0,
          'image': 'pizza.png',
        },
        {
          'text': 'Medium (30cm)',
          'cost': 3.50,
          'image': 'pizza.png',
        },
        {
          'text': 'Large (35cm)',
          'cost': 4.0,
          'image': 'pizza.png',
        },
      },
      'sauce': {
        {
          'text': 'Tomato sauce',
          'cost': 0.5,
          'image': 'tomatoes.png',
        },
        {
          'text': 'Tomato sauce spicy',
          'cost': 0.5,
          'image': 'tomatoes.png',
        },
      },
      'toppings': {
        {
          'text': 'Bacon',
          'cost': 2.7,
          'image': 'bacon.png',
        },
        {
          'text': 'Bellpepper',
          'cost': 0.8,
          'image': 'bellpepper.png',
        },
        {
          'text': 'Olives',
          'cost': 1.5,
          'image': 'olives.png',
        },
        {
          'text': 'Onions',
          'cost': 0.6,
          'image': 'onions.png',
        },
        {
          'text': 'Pineapple',
          'cost': 1.6,
          'image': 'pineapple.png',
        },
        {
          'text': 'Extra Cheese',
          'cost': 1.2,
          'image': 'cheese.png',
        },
      },
    }
  ];
  */

  Map size = {};
  Map sauce = {};
  Map toppings = {};
  int indexToppings = 0;

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
      toppings[indexToppings] = {
        'text': option,
        'cost': optionCost,
        'image': image
      };
      indexToppings++;
    }

    print('toppings is $toppings');
    print('toppings.length is: ' + toppings.length.toString());
    notifyListeners();
  }
}
