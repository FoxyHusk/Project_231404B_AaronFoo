import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/firebaseauth_service.dart';
import '../screens/addrecord_page.dart';
import '../screens/showrecords_page.dart';
import '../model/user.dart' as appmodel;
import '../services/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreService().readUserDetailsByEmail(
          FirebaseAuth.instance.currentUser?.email ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data as appmodel.User?;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME ${user?.firstname ?? ''} ${user?.lastname ?? ''}', 
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_box),
                      iconSize: 60,
                      tooltip: 'Order food',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const AddFoodPage())
                        );
                      }, 
                    ),
                    IconButton(
                      icon: const Icon(Icons.list),
                      iconSize: 60,
                      tooltip: 'view cart',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const RecordsPage())
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }
          return Center(child: Text('Error loading user details'));
        },
      ),
    );
  }
}