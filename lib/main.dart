import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pizzaconfigurator/pizza_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:pizzaconfigurator/database/firestore_methods.dart';
import 'package:pizzaconfigurator/options/size.dart';
import 'package:pizzaconfigurator/options/sauce.dart';
import 'package:pizzaconfigurator/options/toppings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => PizzaProvider(),
      child: const MyApp(),
    ),
  );
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

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final String autoId = DateTime.now().microsecondsSinceEpoch.toString();

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
                  //await _firebaseServices.createNewPizza(autoId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Size(),
                    ),
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
