import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/database/firestore_methods.dart';
import 'package:pizzaconfigurator/global/loading.dart';
import 'package:pizzaconfigurator/main.dart';
import 'package:pizzaconfigurator/order_progress.dart';
import 'package:pizzaconfigurator/single_option.dart';

class Sauce extends StatefulWidget {
  final String? autoId;
  const Sauce({Key? key, this.autoId}) : super(key: key);

  @override
  State<Sauce> createState() => _SauceState();
}

class _SauceState extends State<Sauce> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  //final String _optionText = '1. Choose your sauce';

  List chosenOption = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firebaseServices.getPizza(widget.autoId!),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Loading(),
              ],
            );
          }

          if (snapshot.hasData) {}
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Pizza Configurator - Choose your sauce',
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
                    autoId: widget.autoId,
                    onCountChange: (List pizza) {
                      setState(() {
                        chosenOption = pizza;
                      });
                    },
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
                              OrderProgress(
                                autoId: widget.autoId,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15.0,
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text(
                              'Next',
                            ),
                            onPressed: () {
                              snapshot.data!.get('sauce') == ''
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text('Please choose a sauce'),
                                      duration: Duration(seconds: 3),
                                    ))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Sauce()),
                                    );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
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
        });
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
