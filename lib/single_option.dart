import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/pizza_provider.dart';
import 'package:provider/provider.dart';

class SingleOption extends StatefulWidget {
  final VoidCallback? onCountSelected;
  final Function(List)? onCountChange;
  final String? option;
  const SingleOption({
    Key? key,
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
      'image': 'Pizza.png',
    },
    {
      'text': 'Medium (30cm)',
      'cost': 3.50,
      'image': 'Pizza.png',
    },
    {
      'text': 'Large (35cm)',
      'cost': 4.0,
      'image': 'Pizza.png',
    }
  ];

  final List sauce = [
    {
      'text': 'Tomato sauce',
      'cost': 0.5,
      'image': 'Tomatoes.png',
    },
    {
      'text': 'Tomato sauce spicy',
      'cost': 0.5,
      'image': 'Tomatoes.png',
    },
  ];

  final List toppings = [
    {
      'text': 'Bacon',
      'cost': 2.7,
      'image': 'Bacon.png',
    },
    {
      'text': 'Bellpepper',
      'cost': 0.8,
      'image': 'Bellpepper.png',
    },
    {
      'text': 'Olives',
      'cost': 1.5,
      'image': 'Olives.png',
    },
    {
      'text': 'Onions',
      'cost': 0.6,
      'image': 'Onions.png',
    },
    {
      'text': 'Pineapple',
      'cost': 1.6,
      'image': 'Pineapple.png',
    },
    {
      'text': 'Cheese',
      'cost': 1.2,
      'image': 'Cheese.png',
    },
  ];

  List options = [];

  String _size = '';
  double _costSize = 0.0;
  String _sauce = '';
  double _costSauce = 0.0;
  //List _toppings = [];
  Map _toppings = {};

  markOption(String option, String chosenOption, double chosenCost) {
    if (option == 'size') {
      setState(() {
        _size = chosenOption;
        _costSize = chosenCost;
      });
    } else if (option == 'sauce') {
      setState(() {
        _sauce = chosenOption;
        _costSauce = chosenCost;
      });
    } else if (option == 'toppings') {
      if (!_toppings.containsValue(chosenOption)) {
        _toppings[chosenOption] = chosenCost;
      }
      setState(() {
        _toppings = _toppings;
      });
    }
  }

  _clearToppings() async {
    Provider.of<PizzaProvider>(context, listen: false).deleteToppings();
    setState(() {
      _toppings = {};
    });
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
          widget.option!.replaceFirst(widget.option.toString()[0],
              widget.option.toString()[0].toUpperCase()),
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
                  color: _size == option['text'] ||
                          _sauce == option['text'] ||
                          _toppings.containsKey(option['text'])
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
                  markOption(widget.option!, option['text'], option['cost']);
                  Provider.of<PizzaProvider>(context, listen: false)
                      .addOptionToPizza(widget.option!, option['text'],
                          option['cost'], option['image']);
                }),
          );
        },
      )),
      widget.option == 'toppings'
          ? Column(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text(
                    'Clear all toppings',
                  ),
                  onPressed: () => {_clearToppings()},
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.red)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            )
          : Container(),
    ]);
  }
}
