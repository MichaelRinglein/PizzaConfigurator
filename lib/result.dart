import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/main.dart';
import 'package:pizzaconfigurator/options/sauce.dart';
import 'package:pizzaconfigurator/options/size.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Result extends StatefulWidget {
  final List? createdPizza;
  const Result({Key? key, this.createdPizza}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final String _optionText = 'Your pizza is ready';

  String _size = '';
  double _costSize = 0.0;
  String _sauce = '';
  double _costSauce = 0.0;
  double _totalPrice = 0.0;
  List _toppings = [];
  double _costToppings = 0.0;

  //TODO: Delete initState?
  @protected
  @mustCallSuper
  void initState() {
    //when coming from another page, init state with value from constructor
    _size = widget.createdPizza![0]['size'];
    _costSize = widget.createdPizza![0]['cost'];
    _sauce = widget.createdPizza![1]['sauce'];
    _costSauce = widget.createdPizza![1]['cost'];
    _toppings = widget.createdPizza![2]['toppings'];

    for (var i = 0; i < _toppings.length; i++) {
      _costToppings += _toppings[i].elementAt(1);
    }

/*
    for (var i in widget.createdPizza![i]['toppings'][1].elementAt(1)) {
      _toppingsCost += costs[1];
    }
    print('toppingsCost is: ' + _toppingsCost.toString());
   

    print('widget.createdPizza![2][\'toppings\'][1].elementAt(1) is: ' +
        widget.createdPizza![2]['toppings'][1].elementAt(1).toString());
    print('widget.createdPizza![2][\'toppings\'][2].elementAt(1) is: ' +
        widget.createdPizza![2]['toppings'][2].elementAt(1).toString());
    print('widget.createdPizza![2][\'toppings\'][3].elementAt(1) is: ' +
        widget.createdPizza![2]['toppings'][3].elementAt(1).toString());

        */

    _totalPrice = _costSize + _costSauce + _costToppings;
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
              tooltip: 'Back to start',
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
                value: 1.0,
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
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Size',
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            ResponsiveGridList(
              horizontalGridSpacing: 16, // Horizontal space between grid items
              verticalGridSpacing: 16, // Vertical space between grid items
              horizontalGridMargin: 10, // Horizontal space around the grid
              verticalGridMargin: 10, // Vertical space around the grid
              minItemWidth:
                  300, // The minimum item width (can be smaller, if the layout constraints are smaller)
              maxItemsPerRow:
                  1, // The maximum items to show in a single row. Can be useful on large screens
              shrinkWrap: true, // shrinkWrap property of the ListView.builder()
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/pizza.png',
                            height: 100.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            _size,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '\$' + _costSize.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                Text(
                  'Sauce',
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            ResponsiveGridList(
              horizontalGridSpacing: 16, // Horizontal space between grid items
              verticalGridSpacing: 16, // Vertical space between grid items
              horizontalGridMargin: 10, // Horizontal space around the grid
              verticalGridMargin: 10, // Vertical space around the grid
              minItemWidth:
                  300, // The minimum item width (can be smaller, if the layout constraints are smaller)
              maxItemsPerRow:
                  1, // The maximum items to show in a single row. Can be useful on large screens
              shrinkWrap: true, // shrinkWrap property of the ListView.builder()
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/tomatoes.png',
                            height: 100.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            _sauce,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '\$' + _costSauce.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                Text(
                  'Toppings',
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            ResponsiveGridList(
              horizontalGridSpacing: 16, // Horizontal space between grid items
              verticalGridSpacing: 16, // Vertical space between grid items
              horizontalGridMargin: 10, // Horizontal space around the grid
              verticalGridMargin: 10, // Vertical space around the grid
              minItemWidth:
                  300, // The minimum item width (can be smaller, if the layout constraints are smaller)
              maxItemsPerRow:
                  4, // The maximum items to show in a single row. Can be useful on large screens
              shrinkWrap: true, // shrinkWrap property of the ListView.builder()
              children: [
                ...(_toppings.map((topping) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/' + topping.elementAt(2),
                              height: 100.0,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              topping.elementAt(0),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '\$' + topping.elementAt(1).toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
              ], // The list of widgets in the list
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
                      'Total Price',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      '\$' + _totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
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
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text(
                    'Order',
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const FinishPopUp(),
                  ),
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

class FinishPopUp extends StatelessWidget {
  const FinishPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Thank you for using this Configurator'),
        content: const Text(
            'Unfortunately you can\'t really order a pizza here. This is a demo product configurator.'),
        actions: [
          TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
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
        ]);
  }
}
