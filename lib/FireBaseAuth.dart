import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpWidget extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text("New FireBase User"),
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
            child: FlatButton(
              child: Text("Submit"),
              onPressed: () async {
                try {
                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.value.toString(),
                    password: _passwordController.value.toString()
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }},
            ))
      ],
    );
  }
}
