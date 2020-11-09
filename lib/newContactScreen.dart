import 'package:distress_assistant/chatScreen.dart';
import 'package:distress_assistant/mainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'loginPage.dart';

class newContact extends StatefulWidget {
  static const String id = 'newContact';
  @override
  _newContactState createState() => _newContactState();
}

class _newContactState extends State<newContact> {
  int _selectedIndex = 1;
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

  List<String> people = [];
  TextEditingController _controllerPeople = new TextEditingController();
  TextEditingController _controllermsg = new TextEditingController();
  String msg = null;

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

  Widget _phoneTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[300]),
            top: BorderSide(color: Colors.grey[300]),
            left: BorderSide(color: Colors.grey[300]),
            right: BorderSide(color: Colors.grey[300]),
          )),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => setState(() => people.remove(name)),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    name,
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Contact and Message',
            style: TextStyle(
                fontFamily: "IndieFlower",
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28),
          ),
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
            ListView(
              children: <Widget>[
                people == null || people.isEmpty
                    ? Container(
                        height: 0.0,
                      )
                    : Container(
                        height: 90.0,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List<Widget>.generate(people.length,
                                (int index) {
                              return _phoneTile(people[index]);
                            }),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.people, color: Colors.white),
                  title: TextField(
                    controller: _controllerPeople,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: " Add Contact",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) => setState(() {}),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: _controllerPeople.text.isEmpty
                        ? null
                        : () => setState(() {
                              people.add(_controllerPeople.text.toString());
                              _controllerPeople.clear();
                              print(people);
                            }),
                  ),
                ),
                Divider(color: Colors.white),
                ListTile(
                  leading: Icon(Icons.message, color: Colors.white),
                  title: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: " Add Message",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                    ),
                    controller: _controllermsg,
                    onChanged: (String value) => setState(() {
                      msg = _controllermsg.text;
                      print(msg);
                    }),
                  ),
                ),
                Divider(color: Colors.white),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: FlatButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.all(12),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => newContact(),
                          ));
                    },
                    child: Text(
                      'SAVE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    color: Color(0xFF8F4FA0),
                  ),
                ),
                SizedBox(
                  height: 376,
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
                            text: 'Contact',
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
          ],
        ),
      ),
    );
  }
}
