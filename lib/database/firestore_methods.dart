import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirebaseServices {
  //FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('pizzas');

  //final String autoIdOld = DateTime.now().microsecondsSinceEpoch.toString();

  //Create new pizza in Firebase on get started button click with auto-id
  Future<void> createNewPizza(String autoId) async {
    try {
      await _reference.doc(autoId).set({
        'size': '',
        'sizeCost': 0.0,
        'sauce': '',
        'toppings': [],
      });
      print('createNewPizza() with autoId $autoId');
    } catch (e) {
      print('Error while createNewPizza(): ' + e.toString());
    }
  }

  //if option is selected on GuestureDetector, add to pizza with auto-id

  Future<void> addOption(String autoId, String part, String cost, String option,
      double optionCost) async {
    try {
      await _reference.doc(autoId).set({part: option, cost: optionCost});
      print(
          'addOption() with autoId $autoId, part $part and option $option with cost $cost of $optionCost');
    } catch (e) {
      'Error while addOption(): ' + e.toString();
    }
  }

  //get the current pizza via stream
  // TODO: fix this autoID
  Stream<DocumentSnapshot> getPizza(String autoId) {
    return _reference.doc(autoId).snapshots();
  }
}
