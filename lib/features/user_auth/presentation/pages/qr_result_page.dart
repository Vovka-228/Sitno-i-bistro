import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:auther/data_firebase/data_firebase.dart';

final db = FirebaseFirestore.instance;


class QrResultPage extends StatelessWidget {
  final String code;
  final Function() closeScreen;



  const QrResultPage({super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    final products = Products();
    String urlImage = (products.image).toString();

    return Scaffold(
        backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          closeScreen();
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text("QR Scanner"),
      ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Image.network("${products.image}"),)],

          // children: [ElevatedButton(onPressed: (){
          //   products.getDataFirebase();
          // }, child: Text("Click", style: TextStyle(fontSize: 22)))],
        )
    );
  }

  // void pol() async {
  //
  //   final docRef = db.collection("products").doc("KT7kSOpXOYC9b3JWuEpV");
  //   docRef.get().then((DocumentSnapshot doc){
  //     final data = doc.data() as Map <String, dynamic>;
  //     print(data);
  //
  //   },
  //     onError: (e) => print("Error getting document: $e"),);
  // }
}
