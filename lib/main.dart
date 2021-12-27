import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/options/size.dart';
import 'package:pizzaconfigurator/options/sauce.dart';
import 'package:pizzaconfigurator/options/toppings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        backgroundColor: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/step-1-size': (context) => const Size(),
        '/step-2-sauce': (context) => const Sauce(),
        '/step-3-toppings': (context) => const Toppings(),
      },
      //home: const MyHomePage());
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  List createdPizza = [
    {
      'size': '',
      'cost': 0.0,
    },
    {
      'sauce': '',
      'cost': 0.0,
    },
    {
      'toppings': [],
    },
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Configurator'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Configure a tasty pizza in 3 steps!',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                'assets/pizza.png',
                height: 200.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                child: const Text(
                  'Start!',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Size(createdPizza: widget.createdPizza)),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
