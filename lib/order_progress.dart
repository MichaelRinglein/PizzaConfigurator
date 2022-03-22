import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/database/firestore_methods.dart';
import 'package:pizzaconfigurator/global/loading.dart';
import 'package:pizzaconfigurator/pizza_provider.dart';
import 'package:provider/provider.dart';

class OrderProgress extends StatefulWidget {
  const OrderProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderProgress> createState() => _OrderProgressState();
}

class _OrderProgressState extends State<OrderProgress> {
  //final FirebaseServices _firebaseServices = FirebaseServices();
  Map newPizzaMap = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<PizzaProvider>(
      builder: (context, value, child) {
        //print('value is: ' + value.toString());

        return Column(
          children: [
            Row(
              children: [
                Text(
                  value.size.isNotEmpty ? value.size['text'] : '',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                Text(
                  value.size.isNotEmpty
                      ? '\$ ' + value.size['cost'].toString()
                      : '',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  value.sauce.isNotEmpty ? value.sauce['text'] : '',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                Text(
                  value.sauce.isNotEmpty
                      ? '\$ ' + value.sauce['cost'].toString()
                      : '',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            //for (int i = 0; i <= value.toppings.length; i++)
            for (var entry in value.toppings.entries)
              Row(
                children: [
                  //Text('i is: ' + i.toString()),
                  Text(
                    value.toppings.isNotEmpty ? entry.key : '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    value.toppings.isNotEmpty
                        ? '\$ ' + entry.value.toString()
                        : '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
