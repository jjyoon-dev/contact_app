import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// stless 입력후 tap키
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: Container(
            height: 150,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Image.asset('assets/camera.jpg'),
                Expanded(
                  child: Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('카메라 팝니다.', style: TextStyle(fontWeight: FontWeight.w800) ,),
                          Text('대구시 수성구'),
                          Text('100,000원'),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.favorite),
                                Text('4'),
                              ]
                          )
                        ],
                      )
                  )
                )
              ]
            )
          )
        )
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset('doge.png')
//
//       ),
//     );
//   }
// }
