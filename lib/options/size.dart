import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/main.dart';
import 'package:pizzaconfigurator/options/sauce.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Size extends StatefulWidget {
  final List? createdPizza;
  const Size({Key? key, this.createdPizza}) : super(key: key);

  @override
  State<Size> createState() => _SizeState();
}

class _SizeState extends State<Size> {
  final String _optionText = '1. Choose your size';
  final List? _options = [
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
  ];

  String _size = '';
  double _cost = 0.0;

  //TODO: Delete initState?
  @protected
  @mustCallSuper
  void initState() {
    //when coming from another page, init state with value from constructor
    _size = widget.createdPizza![0]['size'];
    _cost = widget.createdPizza![0]['cost'];
  }

  _addOption(String chosenOption, double chosenCost) {
    setState(() {
      //set the new chosenOption
      _size = chosenOption;
      _cost = chosenCost;
      widget.createdPizza![0]['size'] = chosenOption;
      widget.createdPizza![0]['cost'] = chosenCost;
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
        //TODO Global home button
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LinearProgressIndicator(
                value: 0.3,
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
                ...(_options!.map(
                  (option) {
                    var imageURL = '../assets/' + option['image'];
                    var optionCost = option['cost'];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            color: _size == option['text']
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
                            _addOption(option['text'], option['cost']);
                          }),
                    );
                  },
                )),
              ], // The list of widgets in the list
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  children: [
                    const Text(
                      'Your Order:',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _size,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          _cost == 0.0 ? '' : '\$' + _cost.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15.0,
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
                    _size == ''
                        ? ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text('Please choose a size'),
                            duration: Duration(seconds: 3),
                          ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Sauce(createdPizza: widget.createdPizza)),
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
      content: const Text('Are you sure you want to start from the beginning'),
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
          },
        ),
      ],
    );
  }
}
