import 'package:distress_assistant/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:distress_assistant/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:distress_assistant/roundBtn.dart';
import 'package:distress_assistant/RegistrationScreen.dart';


class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailInputController,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: _pwdInputController,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonName: 'Log In',
                buttonColor: Colors.lightBlueAccent,
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    print('Signin execution started');
                    final user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailInputController.text,
                            password: _pwdInputController.text);
                    setState(() {
                      showSpinner = false;
                    });
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => mainScreen()));
                    }
                  } catch (err) {
                    AlertDialog(
                      title: Text("Error"),
                      content: Text(err.toString()),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                      child: Text(
                        "Register here!",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 20,
                            fontFamily: 'Shadows',
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registrationScreen()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
