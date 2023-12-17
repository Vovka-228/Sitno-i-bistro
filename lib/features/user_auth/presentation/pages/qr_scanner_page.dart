import 'dart:typed_data';
import 'package:auther/features/user_auth/presentation/pages/qr_result_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

import '../../../../data_firebase/data_firebase.dart';


const bgColor = Color(0xfffafafa);
String? code;

class QrScannerPage extends StatefulWidget {

  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {


  bool isScanCompleted = false;
  bool isFlashOn = false;
  MobileScannerController controller = MobileScannerController();
  final products = Products(name: '', image: '');



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          actions: [IconButton(onPressed: (
              ){
            setState(() {
              isFlashOn = !isFlashOn;
            });
            controller.toggleTorch();
          },
              icon: Icon(Icons.flash_on, color: isFlashOn? Colors.grey : Colors.white,))
          ],
          title: Text("QR Scanner"),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Column(children: [Text("Place the Qr code in the area",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              ),
              SizedBox(height: 10,),
              Text("Scanning will be started autue",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87
              ))],),
            ),
            Expanded(flex: 6, child:
            Stack(
              children: [
                MobileScanner(
                  controller: controller,
                onDetect: (capture){
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;

                  if(!isScanCompleted){
                    code = barcodes[0].rawValue ?? '---';
                    debugPrint('Barcode found! ${code}');
                    isScanCompleted = true;

                    _newRegisterMethod();
                  }
              },),
                QRScannerOverlay(overlayColor: Colors.grey[300], borderColor: Colors.amber,),
            ])),
            // Expanded(child: Container(color: Colors.amber,))
            ],
          )
        ));
  }
  void closeScreen(){
    isScanCompleted = false;
  }
  void _newRegisterMethod() async {
    Map listInfoProducts;
    //List<Object>? listInfoProducts = [];
    listInfoProducts = (await products.getDataFirebase()) as Map;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => QrResultPage(closeScreen: closeScreen, FireData: listInfoProducts)));
  }
}
