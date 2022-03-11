import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzaconfigurator/database/firestore_methods.dart';
import 'package:pizzaconfigurator/global/loading.dart';

class OrderProgress extends StatefulWidget {
  final String? autoId;
  const OrderProgress({Key? key, this.autoId}) : super(key: key);

  @override
  State<OrderProgress> createState() => _OrderProgressState();
}

class _OrderProgressState extends State<OrderProgress> {
  final FirebaseServices _firebaseServices = FirebaseServices();

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
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    snapshot.data!.get('size'),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    snapshot.data!.get('sizeCost') == 0.0
                        ? ''
                        : '\$' + snapshot.data!.get('sizeCost').toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    snapshot.data!.get('sauce'),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    snapshot.data!.get('sauceCost') == 0.0
                        ? ''
                        : '\$' + snapshot.data!.get('sauceCost').toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
