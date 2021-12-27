import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/main.dart';

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

  @protected
  @mustCallSuper
  void initState() {
    _size = widget.createdPizza![0]['size'];
    _costSize = widget.createdPizza![0]['cost'];
    _sauce = widget.createdPizza![1]['sauce'];
    _costSauce = widget.createdPizza![1]['cost'];
    _toppings = widget.createdPizza![2]['toppings'];

    for (var i = 0; i < _toppings.length; i++) {
      _costToppings += _toppings[i].elementAt(1);
    }

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
      body: Column(
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
          Expanded(
            child: ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    _optionText,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/pizza.png',
                                height: 60.0,
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
                  children: const [
                    Text(
                      'Sauce',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ListView(
                  physics: const ScrollPhysics(),
                  // The maximum items to show in a single row. Can be useful on large screens
                  shrinkWrap:
                      true, // shrinkWrap property of the ListView.builder()
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/tomatoes.png',
                                height: 60.0,
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
                  children: const [
                    Text(
                      'Toppings',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap:
                      true, // shrinkWrap property of the ListView.builder()
                  children: [
                    ...(_toppings.map((topping) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/' + topping.elementAt(2),
                                  height: 60.0,
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
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[4],
              color: Colors.white,
            ),
            child: Column(
              children: [
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
                  height: 5.0,
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
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
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
