import 'package:auther/global/common/AddCorsine.dart';
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
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                  controller.toggleTorch();
                },
                icon: Icon(
                  Icons.flash_on,
                  color: isFlashOn ? Colors.grey : Colors.white,
                ))
          ],
          title: Text("QR Scanner"),
        ),
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Place the Qr code in the area",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Scanning will be started autue",
                          style:
                              TextStyle(fontSize: 16, color: Colors.black87)),
                      ElevatedButton(
                          onPressed: () {
                            code = "RhI2gBURg5lGTAmJCNm5"; // УБРАТЬ
                            _QRPageResultStart();
                          },
                          child: Text('Click')),
                    ],
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Stack(children: [
                      MobileScanner(
                        controller: controller,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;

                          if (!isScanCompleted) {
                            code = barcodes[0].rawValue ?? '---';
                            debugPrint('Barcode found! ${code}');
                            isScanCompleted = true;
                            _QRPageResultStart();
                          }
                        },
                      ),
                      QRScannerOverlay(
                        overlayColor: Colors.grey[300],
                        borderColor: Colors.amber,
                      ),
                    ])),
              ],
            )));
  }

  void closeScreen() {
    isScanCompleted = false;
  }

  void _QRPageResultStart() async {
    Map listInfoProducts;
    var FireList = [];

    listInfoProducts = (await products.getDataFirebase(code.toString())) as Map;
    FireList = listInfoProducts["rackOtherProducts"];

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AddCorsine(
                  closeScreen: closeScreen,
                  FireData: listInfoProducts,
                  FireListt: FireList,
                )));
  }
}
