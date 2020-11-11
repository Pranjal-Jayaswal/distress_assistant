import 'package:distress_assistant/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import 'package:sendsms/sendsms.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:distress_assistant/newContactScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chatScreen.dart';

String msg1 = "";
List<String> people2 = people;

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Likes',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: LogOut',
      style: optionStyle,
    ),
  ];
  Position position;
  @override
  void initState() {
    lat_long();
    ShakeDetector.autoStart(onPhoneShake: () {
      start();
    });
    if (msg != null) {
      msg1 = msg;
    }
    super.initState();
  }

  void call1() async {
    await launch('tel:100');
  }

  void call2() async {
    await launch('tel:102');
  }

  void call3() async {
    await launch('tel:101');
  }

  void call4() async {
    await launch('tel:1091');
  }

  void call5() async {
    await launch('tel:1078');
  }

  void call6() async {
    await launch('tel:1363');
  }

  void lat_long() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
    } catch (e) {
      print(e);
    }
  }

  void Nclicked() {
    if (_selectedIndex == 0) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => mainScreen(),
            ));
      });
    } else if (_selectedIndex == 1) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newContact(),
            ));
      });
    } else if (_selectedIndex == 2) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chatScreen(),
            ));
      });
    } else if (_selectedIndex == 3) {
      setState(() {
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => loginPage(),
            ));
      });
    }
  }

  void sseenndd(phonenumber) async {
    // String phoneNumber = "";
    String message = "My location is $position" + " $msg1";
    await Sendsms.onGetPermission();
    setState(() async {
      if (await Sendsms.hasPermission()) {
        await Sendsms.onSendSMS(phonenumber, message);
      }
    });
  }

  void start() async {
    for (int i = 0; i < people2.length; i++) {
      sseenndd(people2.elementAt(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Distress Assistant',
            style: TextStyle(
                fontFamily: "IndieFlower",
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFD6D6D6),
        ),
        body: Stack(
          children: <Widget>[
            Image.asset(
              'myimage/backg.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 3,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        lat_long();
                        start();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      height: 120,
                      width: 300,
                      padding: EdgeInsets.all(8.0),
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFDE403F),
                            Color(0xFF8F4FA0),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Colors.red,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 6, 0, 6),
                        child: Text(
                          "  SHAKE YOUR DEVICE \n                   or\nTAP HERE TO SEND SMS",
                          style: TextStyle(
                              fontSize: 24, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(0),
                          height: 80,
                          width: 160,
                          padding: EdgeInsets.all(8.0),
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF115E9B),
                                Color(0xFF9452A5),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            shadows: <BoxShadow>[
                              BoxShadow(
                                color: Colors.blueAccent,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 30.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(11, 20, 0, 8),
                            child: Text(
                              " TAP and CALL",
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.all(9),
                              onPressed: () {
                                call1();
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                height: 90,
                                width: 100,
                                padding: EdgeInsets.all(0),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF115E9B),
                                      Color(0xFF9452A5),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(9, 28, 9, 15),
                                  child: Text(
                                    "Dial  100",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(9),
                              onPressed: () {
                                call2();
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                //  margin: EdgeInsets.only(bottom: 15.0),
                                height: 90,
                                width: 100,
                                padding: EdgeInsets.all(8.0),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF115E9B),
                                      Color(0xFF9452A5),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(3, 20, 2, 15),
                                  child: Text(
                                    "Ambulance",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(9),
                              onPressed: () {
                                call3();
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                //  margin: EdgeInsets.only(bottom: 15.0),
                                height: 90,
                                width: 100,
                                padding: EdgeInsets.all(8.0),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF115E9B),
                                      Color(0xFF9452A5),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(3, 10, 3, 15),
                                  child: Text(
                                    "     Fire  Assistance",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.all(9),
                              onPressed: () {
                                call4();
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                height: 90,
                                width: 100,
                                padding: EdgeInsets.all(0),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF115E9B),
                                      Color(0xFF9452A5),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(11, 8, 9, 15),
                                  child: Text(
                                    "Women Safety Helpline",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(9),
                              onPressed: () {
                                call5();
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                //  margin: EdgeInsets.only(bottom: 15.0),
                                height: 90,
                                width: 100,
                                padding: EdgeInsets.all(8.0),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF115E9B),
                                      Color(0xFF9452A5),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(3, 10, 3, 15),
                                  child: Text(
                                    "  Disaster Assistance",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(9),
                              onPressed: () {
                                call6();
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                //  margin: EdgeInsets.only(bottom: 15.0),
                                height: 90,
                                width: 100,
                                padding: EdgeInsets.all(8.0),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF115E9B),
                                      Color(0xFF9452A5),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
                                  child: Text(
                                    " Tourist Helpline",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFDE403F),
                          Color(0xFF8F4FA0),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        //side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GNav(
                          gap: 2,
                          activeColor: Colors.white,
                          iconSize: 20,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          duration: Duration(milliseconds: 800),
                          tabBackgroundColor: Colors.grey[800],
                          tabs: [
                            GButton(
                              icon: LineIcons.home,
                              text: 'Home',
                            ),
                            GButton(
                              icon: LineIcons.book,
                              text: 'Contacts',
                            ),
                            GButton(
                              icon: LineIcons.wechat,
                              text: 'Chat',
                            ),
                            GButton(
                              icon: LineIcons.sign_out,
                              text: 'LogOut',
                            ),
                          ],
                          selectedIndex: _selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              _selectedIndex = index;
                              print('selected state: $_selectedIndex');
                              Nclicked();
                            });
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
