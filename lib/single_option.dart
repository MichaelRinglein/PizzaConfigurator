import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/options/size.dart';

class SingleOption extends StatefulWidget {
  final VoidCallback? onCountSelected;
  final Function(List)? onCountChange;
  //final Function? addOptions;
  final List? createdPizza;
  final String? option;
  const SingleOption({
    Key? key,
    this.createdPizza,
    this.option,
    this.onCountSelected,
    @required this.onCountChange,
    //@required this.addOptions
  }) : super(key: key);

  @override
  _SingleOptionState createState() => _SingleOptionState();
}

class _SingleOptionState extends State<SingleOption> {
  final List size = [
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
    }
  ];

  final List sauce = [
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
  ];

  final List toppings = [
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
  ];

  List options = [];

  String _size = '';
  double _costSize = 0.0;
  String _sauce = '';
  double _costSauce = 0.0;
  List _toppings = [];

  @protected
  @mustCallSuper
  void initState() {
    _size = widget.createdPizza![0]['size'];
    _costSize = widget.createdPizza![0]['cost'];
    _sauce = widget.createdPizza![1]['sauce'];
    _costSauce = widget.createdPizza![1]['cost'];
    _toppings = widget.createdPizza![2]['toppings'];
  }

/*
  Stream updateOptions(chosenOption, chosenCost) async* {
    yield chosenOption;
    yield chosenCost;
  }
  */

  addOption(String option, String chosenOption, double chosenCost) {
    //TODO set state according to option

    if (option == 'size') {
      setState(() {
        _size = chosenOption;
        _costSize = chosenCost;
        widget.createdPizza![0]['size'] = chosenOption;
        widget.createdPizza![0]['cost'] = chosenCost;
      });
    }
    //print('chosenOption is: $chosenOption');
    //widget.onOptionAdded!;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.option == 'size') options = size;
    if (widget.option == 'sauce') options = sauce;
    if (widget.option == 'toppings') options = toppings;

    return ListView(shrinkWrap: true, children: [
      const SizedBox(
        height: 10.0,
      ),
      Center(
        child: Text(
          widget.option!,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      ...(options.map(
        (option) {
          var imageURL = 'assets/' + option['image'];
          var optionCost = option['cost'];
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: _size == option['text']
                      ? Colors.grey[200]
                      : Colors.transparent,
                  child: Column(
                    children: [
                      Image.asset(
                        imageURL,
                        height: 60.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        option['text'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$' + optionCost.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  addOption(widget.option!, option['text'], option['cost']);
                  //widget.onCountSelected!();
                  widget.onCountChange!(widget.createdPizza!);
                }),
          );
        },
      ))
    ]);
    //return Container();
  }
}
