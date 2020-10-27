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

class mainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  int _selectedIndex = 0;
  double ngap = 20;
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
      'Index 3: Profile',
      style: optionStyle,
    ),
    Text(
      'Index 4: LogOut',
      style: optionStyle,
    ),
  ];
  Position position;
  @override
  void initState() {
    lat_long();
    ShakeDetector.autoStart(onPhoneShake: () {
      sseenndd();
    });

    super.initState();
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
      print('0 clicked');
    } else if (_selectedIndex == 1) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newContact(),
            ));
      });
      print('1 clicked');
    } else if (_selectedIndex == 2) {
      print('2 clicked');
    } else if (_selectedIndex == 3) {
      print('3 clicked');
    } else if (_selectedIndex == 4) {
      print('4 clicked');
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

  void ngapHandler() {
    setState(() {
      ngap = 7;
    });
  }

  void sseenndd() async {
    String phoneNumber = "+918340792564";
    String message = "$position";
    await Sendsms.onGetPermission();
    setState(() async {
      if (await Sendsms.hasPermission()) {
        await Sendsms.onSendSMS(phoneNumber, message);
      }
    });
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
                        sseenndd();
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
                        padding: EdgeInsets.fromLTRB(24, 8, 8, 8),
                        child: Text(
                          "SHAKE YOUR DEVICE \n                or\n TAP TO SEND TEXT",
                          style: TextStyle(
                              fontSize: 24, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text('logout'),
                    color: Colors.blue,
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginPage(),
                          ));
                    },
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
                          iconSize: 18,
                          padding: EdgeInsets.symmetric(
                              horizontal: ngap, vertical: 5),
                          duration: Duration(milliseconds: 800),
                          tabBackgroundColor: Colors.grey[800],
                          tabs: [
                            GButton(
                              icon: LineIcons.home,
                              text: 'Home',
                            ),
                            GButton(
                              icon: LineIcons.book,
                              text: 'Text',
                            ),
                            GButton(
                              icon: LineIcons.wechat,
                              text: 'Chat',
                            ),
                            GButton(
                              icon: LineIcons.random,
                              text: 'Feedback',
                            ),
                            GButton(
                              icon: LineIcons.sign_out,
                              text: 'LogOut',
                            ),
                          ],
                          selectedIndex: _selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              ngapHandler();
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
