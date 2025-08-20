// ignore_for_file: unnecessary_this

import 'package:firebase_firestoreapp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import '../services/firebaseauth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  String? foodName;
  String? foodDescription;
  String? foodPrice;
  String? foodImage;
  String? foodQuantity;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saving Food Record'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Food Name'),
                  validator: (val) => val!.isEmpty 
                    ? 'Please enter a food name'
                    : null,
                  onSaved: (val) => this.foodName = val,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Food Price'),
                  validator: (val) => val!.isEmpty
                    ? 'Please enter a food price'
                    : null,
                  onSaved: (val) => this.foodPrice = val,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Food Description'),
                  validator: (val) => val!.isEmpty 
                    ? 'Please enter a food description'
                    : null,
                  onSaved: (val) => this.foodDescription = val,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  validator: (val) => val!.isEmpty 
                    ? 'Please enter a quantity'
                    : null,
                  onSaved: (val) => this.foodQuantity = val,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: _submit, 
                    child: Text('Save Food Record'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (this.formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    else {
      return null;
    }

  FirestoreService().addFoodData(foodName!, foodDescription!, foodPrice!, foodQuantity!);

    Fluttertoast.showToast(
      msg: 'Data saved successfully', gravity: ToastGravity.TOP
    );
  }
}