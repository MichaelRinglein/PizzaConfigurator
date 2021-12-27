import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/main.dart';
import 'package:pizzaconfigurator/options/sauce.dart';
import 'package:pizzaconfigurator/options/size.dart';
import 'package:pizzaconfigurator/result.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Toppings extends StatefulWidget {
  final List? createdPizza;
  const Toppings({Key? key, this.createdPizza}) : super(key: key);

  @override
  State<Toppings> createState() => _ToppingsState();
}

class _ToppingsState extends State<Toppings> {
  final String _optionText = '3. Choose your toppings';

  final List? _options = [
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

  List _toppings = [];

  //TODO: Delete initState?
  @protected
  @mustCallSuper
  void initState() {
    //when coming from another page, init state with value from constructor
    _toppings = widget.createdPizza![2]['toppings'];
  }

  _addOption(String chosenOption, double chosenCost, String chosenImageURL) {
    List alreadySelectedToppings = [];
    for (final i in _toppings) {
      alreadySelectedToppings.add(i.elementAt(0).toString());
    }

    if (!alreadySelectedToppings.contains(chosenOption)) {
      _toppings
          .insert(_toppings.length, {chosenOption, chosenCost, chosenImageURL});
    }

    setState(() {
      _toppings = _toppings;
      widget.createdPizza![2]['toppings'] = _toppings;
    });
  }

  _clearOptions() {
    setState(() {
      _toppings = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pizza Configurator',
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const ConfirmDeletePopup(),
              ),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LinearProgressIndicator(
                value: 0.9,
                semanticsLabel: 'Linear progress indicator',
                color: Colors.red,
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              _optionText,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            ResponsiveGridList(
              horizontalGridSpacing: 16, // Horizontal space between grid items
              verticalGridSpacing: 16, // Vertical space between grid items
              horizontalGridMargin: 50, // Horizontal space around the grid
              verticalGridMargin: 50, // Vertical space around the grid
              minItemWidth:
                  300, // The minimum item width (can be smaller, if the layout constraints are smaller)
              maxItemsPerRow:
                  4, // The maximum items to show in a single row. Can be useful on large screens
              shrinkWrap: true, // shrinkWrap property of the ListView.builder()
              children: [
                ...(_options!.map((option) {
                  var imageURL = 'assets/' + option['image'];
                  var optionCost = option['cost'];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          color: _toppings.any(
                                  (element) => element.contains(option['text']))
                              ? Colors.grey[200]
                              : Colors.transparent,
                          child: Column(
                            children: [
                              Image.asset(
                                imageURL,
                                height: 100.0,
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
                          _addOption(
                              option['text'], option['cost'], option['image']);
                        }),
                  );
                })),
              ], // The list of widgets in the list
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text(
                    'Clear all toppings',
                  ),
                  onPressed: () => _clearOptions(),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.red)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Your Order:',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.createdPizza![0]['size'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          '\$' + widget.createdPizza![0]['cost'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.createdPizza![1]['sauce'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          '\$' + widget.createdPizza![1]['cost'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    ...(_toppings.map((topping) {
                      return Row(
                        children: [
                          Text(
                            topping.elementAt(0),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            topping.elementAt(1) == []
                                ? ''
                                : '\$' + topping.elementAt(1).toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    })),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'Back',
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: 15.0),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Next',
                  ),
                  onPressed: () {
                    _toppings.isEmpty
                        ? ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text('Please choose at least one topping'),
                            duration: Duration(seconds: 4),
                          ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Result(createdPizza: widget.createdPizza)),
                          );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmDeletePopup extends StatelessWidget {
  const ConfirmDeletePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Start from Beginning'),
        content:
            const Text('Are you sure you want to start from the beginning'),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton.icon(
              icon: const Icon(Icons.home),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              label: const Text(
                'Start from beginning',
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }),
        ]);
  }
}
