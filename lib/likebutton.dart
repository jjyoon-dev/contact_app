import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// stless 입력후 tap키
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name = ['김영숙', '홍길동', '피자집'];
  var like = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('연락처앱'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) {
          print(i);
          return ListTile(
              leading: Image.asset('assets/user_profile.png'),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name[i]),
                  Text(like[i].toString()),
                ],
              ),
              trailing: ElevatedButton(
                    child: Text('like'),
                    onPressed: () {
                      setState(() {
                        like[i]++;
                      });
                    },
                  ),
              );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.phone),
            Icon(Icons.person),
            Icon(Icons.contact_page),
          ],
        ),
      )),
    ));
  }
}
