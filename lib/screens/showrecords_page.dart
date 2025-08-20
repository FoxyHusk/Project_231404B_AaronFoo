import 'package:flutter/material.dart';
import '../model/food.dart';

import '../services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});
  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Records'),
      ),
      body: FutureBuilder<List<Food>>(
        future: FirestoreService().readFoodData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.data![index].name!,
                        style: TextStyle(color: Colors.blue, fontSize: 16.0),
                      ),
                      Column(
                        children: [
                          Text(
                            snapshot.data![index].price!,
                            style: TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          Text(
                            snapshot.data![index].description!,
                            style: TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                        ],
                      ),
                      IconButton(
                        color: Colors.blue,
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          setState(() {
                            FirestoreService().deleteFoodData(snapshot.data![index].uid!);
                          });
                          Fluttertoast.showToast(
                            msg: 'Data deleted successfully',
                            gravity: ToastGravity.TOP,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Container(
            alignment: AlignmentDirectional.center,
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}