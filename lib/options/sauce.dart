import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/main.dart';
import 'package:pizzaconfigurator/options/size.dart';
import 'package:pizzaconfigurator/options/toppings.dart';
import 'package:pizzaconfigurator/single_option.dart';

class Sauce extends StatefulWidget {
  final List? createdPizza;
  final List? availableOptions;
  const Sauce({Key? key, this.createdPizza, this.availableOptions})
      : super(key: key);

  @override
  State<Sauce> createState() => _SauceState();
}

class _SauceState extends State<Sauce> {
  final String _optionText = '2. Choose your sauce';

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

  _addOption(String chosenOption, double chosenCost) {
    setState(() {
      _sauce = chosenOption;
      _costSauce = chosenCost;
      widget.createdPizza![1]['sauce'] = chosenOption;
      widget.createdPizza![1]['cost'] = chosenCost;
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
              value: 0.6,
              semanticsLabel: 'Linear progress indicator',
              color: Colors.red,
              backgroundColor: Colors.grey[200],
            ),
          ),
          Expanded(
            child: SingleOption(
              //createdPizza: widget.createdPizza,
              option: 'sauce',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          children: [
                            Text(
                              _size.isEmpty ? '' : _size,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 25.0,
                            ),
                            Text(
                              _costSize == 0.0
                                  ? ''
                                  : '\$' + _costSize.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _sauce.isEmpty ? '' : _sauce,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 25.0,
                            ),
                            Text(
                              _costSauce == 0.0
                                  ? ''
                                  : '\$' + _costSauce.toString(),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Size(),
                            ));
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
                        _sauce == ''
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text('Please choose a sauce'),
                                duration: Duration(seconds: 3),
                              ))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Toppings(
                                      createdPizza: widget.createdPizza),
                                ),
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
