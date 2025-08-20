import 'package:firebase_firestoreapp/home_account.dart';
import 'package:flutter/material.dart';
import 'shopping/productpage.dart';
import '../screens/home_page.dart';

class Home extends StatefulWidget {
  final int initialIndex;
  const Home({Key? key, this.initialIndex = 0}) : super(key: key);
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  late int _currentIndex;
  List<Widget> _listPages = [];

  @override
  
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _listPages
      ..add(HomePage())
      ..add(ProductPage())
      ..add(HomeAccountPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.blue[300],
      body: SafeArea(
        child: _listPages[_currentIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue.shade200,
        //shape property must be set to NotchedShape
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_rounded),
              color: Colors.white, 
              tooltip: 'Home',
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              }, 
            ),
            IconButton(
              icon: Icon(Icons.food_bank_outlined),
              color: Colors.white,
              tooltip: 'Order',
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              }, 
            ),
            IconButton(
              icon: Icon(Icons.account_circle_outlined),
              color: Colors.white,
              tooltip: 'Account',
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              }, 
            ),
          ],
        ),
      ),
    );
  }
}
