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

  @override
  Widget build(BuildContext context) {
    return Consumer<PizzaProvider>(
      builder: (context, value, child) {
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
            for (int i = 1; i <= value.toppings.length; i++)
              Row(
                children: [
                  //Text('i is: ' + i.toString()),
                  Text(
                    value.toppings.isNotEmpty
                        ? (i.toString() + value.toppings[0]['text'])
                        : '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    value.toppings.isNotEmpty
                        ? '\$ ' + value.toppings[0]['cost'].toString()
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
