import 'package:auther/global/common/toast.dart';
import 'package:auther/global/functions/CartCounter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../features/user_auth/presentation/pages/Corsine_page.dart';
import '../../features/user_auth/presentation/pages/qr_result_page.dart';

// int cartCount = 0;

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
  bool showCartCount = false;
  int count = 0;

  void updateWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              widget.closeScreen();
              Navigator.pop(context);
              CartCounterr = 0;
              count2 = 0;
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text("QR Scanner"),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                badgeAnimation: const badges.BadgeAnimation.slide(),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                badgeContent: Text(
                  "${plusCartCounter()}",
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      final user_request = <String, String>{
                        "purchases[0][count]": "${plusCartCounter()}",
                      };
                      final db = FirebaseFirestore.instance;

                      final ref = db.collection("users").doc("har2");

                      Map<String, dynamic> map = {
                        "count": count2,
                        "id": widget.FireData?["id"],
                        "price": widget.FireData?["price"] * count2,
                        "image": widget.FireData?["image"],
                        "name": widget.FireData?["name"]
                      };
                      ref.update({
                        "purchases": FieldValue.arrayUnion([map])
                      });
                      countMaps++;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Corsine_page(
                                    closeScreen: widget.closeScreen,
                                    FireData: widget.FireData,
                                    FireListt: widget.FireListt,
                                  )));
                    }),
              )),
          SizedBox(
            width: 20,
          )
        ],
      ),
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
              width: 200,
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
          count = 1;
          count2 = count;
          if (count == 1 && CartCounterr == 0) {
            CartCounterr = 1;
          } else {
            CartCounterr++;
          }
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
                  count2 = count;
                  CartCounterr--;
                  plusCartCounter();
                  if (count == 0) {
                    setState(() {
                      showCounterButton = false;
                      count = 1;
                      count2 = count;
                      // CartCounterr = 0;
                      // plusCartCounter();
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
                    count2 = count;
                    CartCounterr++;
                    plusCartCounter();
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
