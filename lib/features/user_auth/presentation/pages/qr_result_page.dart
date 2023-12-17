import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../firebase_auth_implementetion/parse_modul.dart';

final db = FirebaseFirestore.instance;
final parsee_modul = ImageRequest();


class QrResultPage extends StatefulWidget {
  final Map? FireData;
  final Function() closeScreen;



  QrResultPage({super.key, required this.closeScreen, required this.FireData});

  @override
  State<QrResultPage> createState() => _QrResultPageState();
}

class _QrResultPageState extends State<QrResultPage> {
  String? urlImage;
  //final products = Products();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          widget.closeScreen();
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text("QR Scanner"),
      ),

      body:
      // Column(children: [Center(child: ElevatedButton(child: Text("Click"), onPressed: (){products.getDataFirebase();},),)],)
      Column(children: [Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
        Image.network(widget!.FireData!['image']),
        SizedBox(height: 10),
        Text((widget!.FireData!['name'])),
        SizedBox(height: 10),
        Text((widget!.FireData!['description'])),
        SizedBox(height: 10),
        Text(("Цена: ${widget!.FireData!['price']}"))],))],)

    );


  }



  }

