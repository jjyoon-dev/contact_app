import 'package:flutter/material.dart';

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
  var friend = 4;
  var name = ['김영숙', '홍길동', '피자집'];
  var like = [0, 0, 0];
  var inputName = '';

  addOne(){
    setState((){
      friend++;
    });
  }

  addNewName(inputName){
    setState((){
      if (inputName == '') {
        return;
      } else {
        name.add(inputName);
        like.add(0);
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
          addOne;
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI(addOne : addOne, addNewName : addNewName,);
              });
        },
      ),
      appBar: AppBar(
        title: Text('연락처앱  ' + friend.toString()),

      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, i) {
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
    );
  }
}


// DialogUI
class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.addNewName,}) : super(key: key);
  final addOne;
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
                              addOne();
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

