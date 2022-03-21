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
        'sauceCost': 0.0,
        'toppings': [],
      });
    } catch (e) {
      print('Error while createNewPizza(): ' + e.toString());
    }
  }

  //if option is selected on GuestureDetector, add to pizza with auto-id

  Future<void> addOption(String autoId, String part, String cost, String option,
      double optionCost) async {
    try {
      await _reference.doc(autoId).update({part: option, cost: optionCost});
    } catch (e) {
      'Error while addOption(): ' + e.toString();
    }
  }

  Future<void> addTopping(
      String autoId, String part, String topping, double toppingCost) async {
    try {
      await _reference
          .doc(autoId)
          .collection('toppings')
          .doc(topping)
          .set({'cost': toppingCost});
      //.update({'toppings': FieldValue.arrayUnion(topping)});
    } catch (e) {
      'Error while addOption(): ' + e.toString();
    }
  }

  Future<void> clearToppings(String autoId) async {
    try {
      await _reference.doc(autoId).update({'toppings': FieldValue.delete()});
    } catch (e) {
      'Error while addOption(): ' + e.toString();
    }
  }

  //get the current pizza via stream
  Stream<DocumentSnapshot> getPizza(String autoId) {
    return _reference.doc(autoId).snapshots();
  }

  Stream<QuerySnapshot> getToppings(String autoId) {
    return _reference.doc(autoId).collection('toppings').snapshots();
  }
}
