import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}

// stless 입력후 tap키
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // var friend = 3;
  // var name = [['김영숙', 0], ['홍길동', 0], ['피자집', 0], ['김철수', 1]];
  List<Map> name = [
    {'name' : '김영숙', 'like' : 0},
    {'name' : '홍길동', 'like' : 0},
    {'name' : '치킨집', 'like' : 0},
    {'name' : '피자집', 'like' : 0},
  ];

  // var like = [0, 0, 0];
  var inputName = '';

  addNewName(inputName){
    setState((){
      if (inputName == '') {
        return;
      } else {
        name.add(
          {"name" : inputName, "like" : 0,}
        );
        Navigator.of(context).pop();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(name);
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI(addNewName : addNewName,);
              });
        },
      ),
      appBar: AppBar(
        title: Text('연락처앱  ' + name.length.toString()),

      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Image.asset('assets/user_profile.png'),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name[i]['name'].toString()),
                Text(name[i]['like'].toString()),
              ],
            ),
            trailing: Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  child: Text('like'),
                  onPressed: () {
                    setState(() {
                      name[i]['like'] = (name[i]['like'] as int) + 1;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('delete'),
                  onPressed: () {
                    setState(() {
                      name.removeAt(i);
                      print(name);
                    });
                  },
                ),
              ],
            )

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
    );
  }
}


// DialogUI
class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addNewName,}) : super(key: key);
  final addNewName;
  var inputData = TextEditingController();
  var inputNewName = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        width: 500,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                // controller: inputData,
                onChanged: (text){ inputNewName = text; print(inputNewName);},
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)
                    ),
                    hintText: '텍스트를 입력하세요.'),
              ),
              Container(
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      // color: Colors.green,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: double.infinity,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              addNewName(inputNewName);
                              // Navigator.of(context).pop();
                            },
                            child: Text("완료"),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: double.infinity,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("취소"),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

