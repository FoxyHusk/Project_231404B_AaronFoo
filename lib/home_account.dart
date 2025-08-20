// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'account.dart';
import 'about.dart';

class HomeAccountPage extends StatelessWidget {
	const HomeAccountPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Account & About'),
        automaticallyImplyLeading: false,
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						ElevatedButton.icon(
							icon: Icon(Icons.account_circle),
							label: Text('Account'),
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => AccountPage()),
								);
							},
						),
						SizedBox(height: 10),
						ElevatedButton.icon(
							icon: Icon(Icons.info_outline),
							label: Text('About'),
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => AboutPage()),
								);
							},
						),
					],
				),
			),
		);
	}
}
