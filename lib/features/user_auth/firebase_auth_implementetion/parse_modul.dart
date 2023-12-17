import 'dart:math';

import 'package:http/http.dart' as http;

import '../../../data_firebase/data_firebase.dart';
class ImageRequest{
  
  Future<String> validateImage(String imageUrl) async {
    var uri = await http.get(Uri.parse(imageUrl));
    print('request: ${uri.toString()}');


    if(uri.statusCode == 200){
      return uri.toString();
    }
    else{
      return '';
    }

  }
}


