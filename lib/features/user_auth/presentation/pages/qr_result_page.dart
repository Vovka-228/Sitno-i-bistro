import 'package:auther/features/user_auth/presentation/pages/widgets/ProductCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../global/functions/NextPageReplace.dart';
import '../../firebase_auth_implementetion/parse_modul.dart';

final db = FirebaseFirestore.instance;
final parsee_modul = ImageRequest();

class QrResultPage extends StatefulWidget {
  final Map? FireData;

  var FireListt = [];
  final Function() closeScreen;

  QrResultPage(
      {super.key,
      required this.closeScreen,
      required this.FireData,
      required this.FireListt});

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
          leading: IconButton(
              onPressed: () {
                widget.closeScreen();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text("QR Scanner"),
        ),
        body: ListView(
          children: [
            Image.network(widget!.FireData!['image']),
            Divider(
              color: Colors.black.withOpacity(0.3),
              height: 20,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                (widget!.FireData!['name']),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
                color: Colors.black.withOpacity(0.3),
                height: 20,
                thickness: 1,
                indent: 10,
                endIndent: 10),
            Text((widget!.FireData!['description'])),
            Divider(
                color: Colors.black.withOpacity(0.3),
                height: 20,
                thickness: 1,
                indent: 10,
                endIndent: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                        itemCount: widget!.FireListt.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              color: Colors.black.withOpacity(0.09),
                              width: MediaQuery.of(context).size.width / 2.7,
                              child: ElevatedButton(
                                  onPressed: () {
                                    var OtherProduct = functionsNext(
                                        context,
                                        widget!.FireListt[index]["id"]
                                            .toString());
                                    OtherProduct.QRPageResultStart();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey[400]!
                                                  .withOpacity(0.1))),
                                  child: ProductCard(
                                      widget.FireListt, context, index)));
                        }))
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
