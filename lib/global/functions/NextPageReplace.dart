import 'package:flutter/material.dart';

import '../../data_firebase/data_firebase.dart';
import '../common/AddCorsine.dart';

class functionsNext {
  final products = Products(name: '', image: '');
  bool isScanCompleted2 = true;
  var context2;
  String? code2;

  functionsNext(var context, String code) {
    context2 = context;
    code2 = code;
  }

  void closeScreen() {
    isScanCompleted2 = false;
  }

  void QRPageResultStart() async {
    Map listInfoProducts;
    var FireList = [];

    listInfoProducts =
        (await products.getDataFirebase(code2.toString())) as Map;
    FireList = listInfoProducts["rackOtherProducts"];

    Navigator.pushReplacement(
        context2,
        MaterialPageRoute(
            builder: (context) => AddCorsine(
                  closeScreen: closeScreen,
                  FireData: listInfoProducts,
                  FireListt: FireList,
                )));
  }
}
