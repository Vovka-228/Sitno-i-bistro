import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("HomePage"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.end
          ,children: [Center(
            child: Container(
              padding:EdgeInsets.symmetric(horizontal: 20) ,
              width: double.infinity,
              child: TextButton(
                onPressed: (){Navigator.pushNamed(context, "/qr_scanner");},
                child: Text("Купить продукцию"),
                style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orange[300],
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    padding: EdgeInsets.all(20)),),
            ),
          ),
            SizedBox(height: 30),
            
          ],
        )
    );
  }
}
//Navigator.pushNamed(context, "/qr_scanner"
