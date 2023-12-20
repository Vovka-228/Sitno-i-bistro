import 'package:auther/global/common/toast.dart';
import 'package:flutter/material.dart';

import '../../features/user_auth/presentation/pages/qr_result_page.dart';

class AddCorsine extends StatefulWidget {
  final Map? FireData;

  var FireListt = [];
  final Function() closeScreen;

  AddCorsine(
      {super.key,
      required this.closeScreen,
      required this.FireData,
      required this.FireListt});

  @override
  State<AddCorsine> createState() => _AddCorsineState();
}

class _AddCorsineState extends State<AddCorsine> {
  bool showCounterButton = false;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: QrResultPage(
        closeScreen: widget.closeScreen,
        FireData: widget.FireData,
        FireListt: widget.FireListt,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
            color: Colors.white),
        height: 60,
        child: Row(
          children: <Widget>[
            Divider(height: 1, color: Colors.grey),
            Container(
              height: 60,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Цена: ${widget.FireData!['price']} ₽',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                child: showCounterButton ? buttonCounter() : buttonPlus()),
          ],
        ),
      ),
    );
  }

  Widget buttonPlus() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showCounterButton = true;
        });
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.orange[300]!),
          fixedSize: MaterialStateProperty.all(const Size(155, 40))),
      child: Container(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              )
            ]),
          )),
    );
  }

  Widget buttonCounter() {
    return Container(
      width: 155,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  count--;
                  if (count == 0) {
                    setState(() {
                      showCounterButton = false;
                      count = 1;
                    });
                  }
                });
              },
              icon: Icon(Icons.remove)),
          Container(
            width: 55,
            child: Center(
              child: Text(
                '$count',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (count < widget.FireData!["count"]) {
                  setState(() {
                    count++;
                  });
                } else {
                  showToast(
                      message:
                          "Выбрано максимальное количество товара на полке");
                }
              },
              icon: Icon(Icons.add)),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.orange[300],
      ),
    );
  }
}
