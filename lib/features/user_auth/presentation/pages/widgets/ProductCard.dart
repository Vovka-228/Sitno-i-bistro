import 'package:flutter/material.dart';

Widget ProductCard(var FireListt, context, int index) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Column(
          children: [
            Image.network(
              FireListt[index]['image'],
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: Text(
                FireListt[index]['name'],
                style: TextStyle(fontSize: 15, color: Colors.black87),
                maxLines: 4,
              ),
            ),
            //AddCorsineForCard(FireListt2: FireListt, index2: index)
          ],
        ),
      )
    ],
  );
}
