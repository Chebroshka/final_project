import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _nameFieldController = TextEditingController();
  var _emailFieldController = TextEditingController();
  var _passwordFieldController = TextEditingController();
  var _reEnterPasswordFieldController = TextEditingController();

  bool _showPassword1 = false;
  bool _showPassword2 = false;

  bool isValidEmail(String input) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zAZ0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailRegex.hasMatch(input);
  }

  bool isValidPhone(String input) {
    return RegExp(r"^[0-9]{10}$").hasMatch(input);
    //https://regex101.com/
  }

  void _togglevisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
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
        title: Text('Sign Up Screen'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your full name',
                labelText: 'Name',
              ),
              controller: _nameFieldController,
              validator: (val) => val.isEmpty ? 'Name is required' : null,
            ),
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
            ),
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
            ),
            TextFormField(
              obscureText: !_showPassword2,
              decoration: InputDecoration(
                icon: Icon(Icons.autorenew),
                hintText: 'Re-Enter your Password',
                labelText: 'Re-Enter Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    _togglevisibility2();
                  },
                  child: Icon(
                    _showPassword2 ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: _reEnterPasswordFieldController,
              validator: (val) => val == _passwordFieldController.text
                  ? null
                  : 'Passwords do not match',
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0),
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var url =
                        "mailto:${_emailFieldController.text}?subject=Lab%204%20Email%20Form&body=Name: ${_nameFieldController.text}\nEmail: ${_emailFieldController.text}\nPassword: ${_passwordFieldController.text}";
                    print(url); //Todo replaset with send to backend
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
