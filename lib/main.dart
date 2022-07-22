import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  getPermission() async {
    var status = await Permission.contacts.status; // 연락처 권한줬는지 여부
    if (status.isGranted) {
      print('허락됨');
      // 연락처 꺼내기
      var contacts = await ContactsService.getContacts();
      setState(() {
        contactList = contacts;
      });
      // 연락처 추가하는 법
      // var newPerson = new Contact(); //new 는 생략가능
      // newPerson.givenName = '민수';
      // newPerson.familyName = '김';
      // await ContactsService.addContact(newPerson);

    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request(); // 허락해달라고 팝업띄우는 코드
      // openAppSettings(); //앱 설정화면 켜줌. 유저가 직접 권한 설정 가능.
    }
  }

  // 앱이 실행될때 함수 실행 // initState 안에 적은 코드는 위젯 로드될 때 한번 실행됨.
  // @override
  // void initState() {
  //   super.initState();
  //   getPermission();
  // }
  // → 요즘은 앱 실행할때 바로 권한 요청하지 않음. 기능 실행할때 요청하는게 좋음.

  // var friend = 3;
  // var name = [['김영숙', 0], ['홍길동', 0], ['피자집', 0], ['김철수', 1]];
  // List<Map> name = [
  //   {'name' : '김영숙', 'like' : 0},
  //   {'name' : '홍길동', 'like' : 0},
  //   {'name' : '치킨집', 'like' : 0},
  //   {'name' : '피자집', 'like' : 0},
  // ];

  List<Contact> contactList = [];

  List<int> like = [0, 0, 0]; // var like -> List<int> list인데 int만 있는 list
  var inputName = '';

  addNewName(inputName) {
    setState(() {
      if (inputName == '') {
        return;
      } else {
        contactList.add(inputName);
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(contactList);
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI(
                  addNewName: addNewName,
                );
              });
        },
      ),
      appBar: AppBar(
        title: Text('연락처앱  ' + contactList.length.toString()),
        actions: [
          IconButton(
              onPressed: () {
                getPermission();
              },
              icon: Icon(Icons.contacts)),
        ],
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, i) {
          return ListTile(
              leading: Image.asset('assets/user_profile.png'),
              // title: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(name[i]['name'].toString()),
              //     Text(name[i]['like'].toString()),
              //   ],
              // ),
              title: Text(contactList[i].givenName ?? '이름이 없습니다.'),
              // ?? 왼쪽변수가 null이면 오른쪽을 남겨라. null check 삼항연산자
              trailing: Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    child: Text('like'),
                    onPressed: () {
                      setState(() {
                        like[i] = like[i] + 1;
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('delete'),
                    onPressed: () {
                      setState(() {
                        contactList.removeAt(i);
                        print(contactList);
                      });
                    },
                  ),
                ],
              ));
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
  DialogUI({
    Key? key,
    this.addNewName,
  }) : super(key: key);
  final addNewName;
  var inputData = TextEditingController();
  var inputNewName = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: 500,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: Text('연락처 추가하기', style: TextStyle(fontSize: 22))),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: TextField(
                    // controller: inputData,
                    onChanged: (text) {
                      inputNewName = text;
                      print(inputNewName);
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: '성'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: TextField(
                    // controller: inputData,
                    onChanged: (text) {
                      inputNewName = text;
                      print(inputNewName);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue.shade50, // TextFiled 배경색
                        icon: Icon(Icons.star), // TextField 앞에 아이콘 추가
                        prefixIcon: Icon(Icons.star), // TextField 안쪽 앞에 아이콘 추가
                        suffixIcon: Icon(Icons.star), // TextField 안쪽 뒤에 아이콘 추가
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10), // border radius 주기
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                        hintText: '이름'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: TextField(
                    // controller: inputData,
                    onChanged: (text) {
                      inputNewName = text;
                      print(inputNewName);
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: '전화번호'),
                  ),
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
                                var newContact = Contact();
                                newContact.givenName =
                                    inputData.text; //새로운 연락처 만들기
                                ContactsService.addContact(
                                    newContact); // 실제로 연락처에 집어넣기
                                addNewName(
                                    inputNewName); // contactList이라는 state에도 저장해보기
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
      ),
    );
  }
}
