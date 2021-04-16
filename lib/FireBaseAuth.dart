import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

///Use the string "FireBase Login" or "Create New User" as arguments in the ScreenArguments object to choose which to use
class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  void showSnackbarError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args =
        ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Stack(
      children: <Widget>[
        Text(args.title),
        TextFormField(
            decoration: InputDecoration(
              hintText: "Enter your email.",
              labelText: "Email",
            ),
            controller: _emailController,
            validator: (val) {
              if (val.isNotEmpty) {
                return null;
              }
              return "Please enter your email.";
            }),
        TextFormField(
            decoration: InputDecoration(
              hintText: "Enter a password.",
              labelText: "Password",
            ),
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            controller: _passwordController,
            validator: (val) {
              if (val.isNotEmpty) {
                return null;
              }
              return "Please enter team name.";
            }),
        Container(
            padding: EdgeInsets.all(20),
            child: TextButton(
              child: Text("Submit"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  switch (args.title) {
                    case "Create New User":
                      {
                        createUser().then((result) {
                          if (result != null) {
                            Navigator.pop(context, result);
                          }
                        });
                      }
                      break;
                    case "FireBase Login":
                      {
                        login().then((result) {
                          if (result != null) {
                            Navigator.pop(context, result);
                          }
                        });
                      }
                      break;
                  }
                }
              },
            ))
      ],
    );
  }

  Future<UserCredential> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.value.toString(),
              password: _passwordController.value.toString());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbarError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackbarError('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.value.toString(),
              password: _passwordController.value.toString());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbarError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackbarError('Wrong password provided for that user.');
      }
    }
    return null;
  }
}

class ScreenArguments {
  final String title;

  //final String message;

  ScreenArguments(this.title);
}
