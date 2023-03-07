import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference database = FirebaseDatabase.instance.ref('users');

  var val;

  int color = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    database.set({
      "backgroundColor": 1,
    });

    database.onValue.listen((DatabaseEvent event) {
      val = event.snapshot.value;

      setState(() {
        color = val['backgroundColor'];

      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(()  {
               database.update({
                "backgroundColor": (color == 1) ? 0 : 1,
              });
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  (color == 1) ? Colors.redAccent : Colors.greenAccent,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          child: const Text('Click'),
        ),
      ),
    );
  }
}
