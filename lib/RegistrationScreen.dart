import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:distress_assistant/Constants.dart';
import 'package:distress_assistant/roundBtn.dart';
import 'package:distress_assistant/mainScreen.dart';

class registrationScreen extends StatefulWidget {

  @override
  _registrationScreenState createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  final _auth = FirebaseAuth.instance;

  final _emailInputController = TextEditingController();
  final _pwdInputController = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    _emailInputController.dispose();
    _pwdInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Color(0xFF222B45),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            alignment: Alignment.center,
            child: SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("myimage/200w.gif"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: _pwdInputController,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RoundedButton(
                    buttonName: 'Register',
                    buttonColor: Colors.lightBlueAccent,
                    onPress: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      _auth
                          .createUserWithEmailAndPassword(
                              email: _emailInputController.text,
                              password: _pwdInputController.text)
                          .then(
                        (value) {
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => mainScreen(),
                            ),
                          );
                        },
                      ).catchError((onError) {
                        setState(() {
                          showSpinner = false;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(onError.toString()),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }).catchError((onError) {
                        setState(() {
                          showSpinner = false;
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
