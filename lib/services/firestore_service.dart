// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/food.dart';
import '../model/user.dart';

class FirestoreService {
  // Create a CollectionReference called foodCollection that references the firestore collection
  final CollectionReference foodCollection = FirebaseFirestore.instance.collection('foods');

  // Foods
  Future<void> addFoodData(String foodName, String foodPrice, String foodQuantity, String foodDescription) async {
    var docRef = FirestoreService().foodCollection.doc();
    debugPrint('add docRef: ' + docRef.id);

    await foodCollection.doc(docRef.id).set({
      'id': docRef.id,
      'name': foodName,
      'price': foodPrice,
      'quantity': foodQuantity
    });
  }
  Future<List<Food>> readFoodData() async {
    List<Food> foodList = [];
    QuerySnapshot snapshot = await foodCollection.get();

    snapshot.docs.forEach((doc) {
      Food food = Food.fromMap(doc.data() as Map<String, dynamic>);
      foodList.add(food);
    });

    debugPrint('Foodlist: $foodList');
    return foodList;
  }

  Future<void> deleteFoodData(String foodId) async {
    await foodCollection.doc(foodId).delete();

    debugPrint('deleting uid:' + foodId);
  }

  Future<void> updateFoodData(
    String foodName,
    String foodPrice,
    String foodDescription,
    String foodId
  ) async {
    var docRef = FirestoreService().foodCollection.doc();
    debugPrint('update docRef: ' + docRef.id);

    await foodCollection.doc(docRef.id).update({
      'uid': docRef.id,
      'name': foodName,
      'price': foodPrice,
      'description': foodDescription,
    });
  }

  Future<void> deleteFoodDoc() async {
    await foodCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  // Users
  Future<void> addUserDetails(String firstName, String lastName, String email, String phone) async {
    var docRef = userCollection.doc();
    await userCollection.doc(docRef.id).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'phone': phone,
    });
  }
  Future<User?> readUserDetailsByEmail(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return User.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    }
    return null;
  }
}