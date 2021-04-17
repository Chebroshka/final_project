import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _emailFieldController = TextEditingController();
  var _passwordFieldController = TextEditingController();
  bool _showPassword1 = false;

  void _togglevisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }

  bool isValidEmail(String input) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zAZ0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailRegex.hasMatch(input);
  }

  bool isValidPassword(String val) {
    bool result = RegExp(
            r"^(?=[^A-Z\s]*[A-Z])(?=[^a-z\s]*[a-z])(?=[^\d\s]*\d)(?=\w*[\W_])\S{6,}$")
        .hasMatch(val);
    if (!result)
      showAlert("Password is invalid",
          "Password must be at least 6 characters,1 number, 1 upper and lowercase letter and 1 special character ex.!@#\$%^&*() with no spaces.");
    return result;
    //https://regex101.com/
  }

  // Perform the following validations:
  void showAlert(String title, String description) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Enter a valid email',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailFieldController,
              validator: (val) =>
                  isValidEmail(val) ? null : 'Invalid Email Address',
            ), //email
            TextFormField(
              obscureText: !_showPassword1,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Enter a Password',
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    _togglevisibility1();
                  },
                  child: Icon(
                    _showPassword1 ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordFieldController,
              validator: (val) =>
                  isValidPassword(val) ? null : "Password is invalid",
            ), //password

            Container(
              padding: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0),
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var url =
                        "email:${_emailFieldController.text}\nPassword: ${_passwordFieldController.text}";
                    print(url); //Todo send to Authenticaiton
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      (SnackBar(
                        content: Text('Invalid form!!!'),
                      )),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
