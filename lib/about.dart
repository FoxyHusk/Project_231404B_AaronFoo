// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
	const AboutPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('About'),
			),
			body: Padding(
				padding: const EdgeInsets.all(24.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Icon(Icons.delivery_dining, size: 80, color: Colors.blueAccent),
						SizedBox(height: 24),
						Text(
							'Food Delivery App',
							style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
							textAlign: TextAlign.center,
						),
						SizedBox(height: 16),
						Text(
							'Order your favorite meals from local restaurants and have them delivered right to your doorstep. Fast, easy, and convenient!',
							style: TextStyle(fontSize: 18),
							textAlign: TextAlign.center,
						),
						SizedBox(height: 24),
						Text(
							'Version 1.0.0',
							style: TextStyle(fontSize: 16, color: Colors.grey),
						),
					],
				),
			),
		);
	}
}
