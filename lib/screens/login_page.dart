// ignore_for_file: prefer_const_constructors

import 'package:firebase_firestoreapp/services/firestore_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import '../services/firebaseauth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Controllers for e-mail and password textfields
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();
  bool signIn = true;

  @override
  void dispose() {
    // Dispose all controllers
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!'))
      );
      return false;
    }
    else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //hide back arrow button
        automaticallyImplyLeading: signIn ? false : true,
        title: signIn ? const Text('Sign In') : const Text('Sign Up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: signIn 
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.person_outlined, 
                    size: 50,
                  ),
                ),
                SizedBox(height: 30),
                Text('Welcome back', 
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                    ),
                    validator: (val) => val!.isEmpty 
                      ? 'Please enter your email'
                      : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: 'Password',
                    ),
                    validator: (val) => val!.isEmpty 
                      ? 'Please enter your password'
                      : null,
                  ),
                ),
                SizedBox(height: 2),
                //Sign in button
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                    else {
                      return;
                    }
                    var reguser = await FirebaseAuthService().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if (reguser != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => signIn ? Home() : LoginPage())
                      );
                    }
                  }, 
                  child: Text('Sign In'),
                ),
                TextButton(
                  onPressed: () {
                    formKey.currentState?.reset();
                    setState(() {
                      signIn = !signIn;
                    });
                  }, 
                  child: signIn 
                    ? Text('Create an account')
                    : Text('Have an account? Sign In')
                ),
              ],
            )
            // Signup
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                Icon(
                  Icons.delivery_dining_outlined,
                  size: 100,
                ),
                SizedBox(height: 30),
                Text(
                  'Please register',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: firstnameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'First Name',
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter your first name' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: lastnameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'Last Name',
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter your last name' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone Number',
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter your phone number' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter your email' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter your password' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Confirm Password',
                    ),
                    validator: (val) => val!.isEmpty 
                    ? 'Please confirm your password' 
                    : null,
                  ),
                ),
                SizedBox(height: 2),
                //Sign up button
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {
                      return;
                    }
                    var newuser = await FirebaseAuthService().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if (newuser != null) {
                      await FirestoreService().addUserDetails(
                        firstnameController.text.trim(),
                        lastnameController.text.trim(),
                        emailController.text.trim(),
                        phoneController.text.trim(),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => signIn ? Home() : LoginPage())
                      );
                    }
                    FirestoreService().addUserDetails(
                      firstnameController.text.trim(),
                      lastnameController.text.trim(),
                      emailController.text.trim(),
                      phoneController.text.trim(),
                    );
                  },
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    formKey.currentState?.reset();
                    setState(() {
                      signIn = !signIn;
                    });
                  },
                  child: signIn
                      ? Text('Create an account')
                      : Text('Have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}