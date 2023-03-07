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

  int color = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    database.set({
      "backgroundColor": 0,
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
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      color: (color == 1) ? Colors.red : Colors.green,
                    ),
                    children: const [
                      TextSpan(
                          text: 'waitwize',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                    ]),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    database.update({
                      "backgroundColor": (color == 1) ? 0 : 1,
                    });
                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: (color == 1) ? Colors.red : Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      (color == 1) ? 'Occupied' : 'Vacant',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Comfortaa'),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'waitwise@2023',
                    style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'about',
                        style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
                      ),
                      Text(
                        'privacy',
                        style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
                      ),
                      Text(
                        'Terms of use',
                        style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
