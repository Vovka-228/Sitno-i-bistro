import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int ih = -1;

class Corsine_page extends StatefulWidget {
  final Map? FireData;

  var FireListt = [];
  final Function() closeScreen;

  Corsine_page(
      {super.key,
      required this.closeScreen,
      required this.FireData,
      required this.FireListt});

  @override
  State<Corsine_page> createState() => _Corsine_pageState();
}

class _Corsine_pageState extends State<Corsine_page> {
  Map<String, dynamic> map = {};
  var purchaseList = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      MapData();
      if (ih < purchaseList.length) {
        ih++;
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              widget.closeScreen();
              Navigator.pop(context);
              ih = 0;
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text("QR Scanner"),
      ),
      body: Container(
        height: 300,
        width: 300,
        child: ListView.builder(
            itemCount: purchaseList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              print("INDEX ${index}");
              return Container(
                height: 100,
                width: 100,
                child: Text("${purchaseList[index]["name"]}"),
              );
            }),
      ),
    );
  }

  void MapData() async {
    final db = FirebaseFirestore.instance;
    final ref = db.collection("users").doc("har2");
    ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        map = data;

        for (int i = 0; i < map['purchases'].length; i++) {
          print("Map: ${map['purchases'][i]}");
          purchaseList.add(map['purchases'][i]);
          print("List: ${purchaseList[i]} index ${i}");
        }
        log("Успех");
        print(map);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

// int PlusI() {
//   ih++;
//   print("Циферка: ${ih}");
//   return ih;
// }
}
