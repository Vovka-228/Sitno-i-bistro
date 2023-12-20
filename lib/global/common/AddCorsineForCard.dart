import 'package:auther/global/common/toast.dart';
import 'package:flutter/material.dart';

class AddCorsineForCard extends StatefulWidget {
  var FireListt2 = [];
  int index2 = 0;

  AddCorsineForCard({
    super.key,
    required this.FireListt2,
    required this.index2,
  });

  @override
  State<AddCorsineForCard> createState() => _AddCorsineForCardState();
}

class _AddCorsineForCardState extends State<AddCorsineForCard> {
  bool showCounterButton = false;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: showCounterButton ? buttonCounter() : buttonPlus(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.orange[300],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
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
            icon: Icon(
              Icons.remove,
              color: Colors.black,
              size: 13,
            )),
        Container(
          width: 22,
          child: Center(
            child: Text(
              '$count',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              if (count < widget.FireListt2![widget.index2]["count"]) {
                setState(() {
                  count++;
                });
              } else {
                showToast(
                    message: "Выбрано максимальное количество товара на полке");
              }
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 13,
            )),
      ],
    );
  }
}
