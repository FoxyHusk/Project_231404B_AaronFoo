// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import '../model/user.dart' as appmodel;
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'screens/login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Account Page'),
      ),
      body: FutureBuilder(
        future: FirestoreService().readUserDetailsByEmail(
          FirebaseAuth.instance.currentUser?.email ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data as appmodel.User;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.account_circle, size: 60.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      '${user.firstname ?? ''} ${user.lastname ?? ''}',
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Email: ${user.email ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Phone: ${user.phone ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        );
                        Navigator.push(context, route);
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: Text('Error loading user details'));
        },
      ),
    );
  }
}