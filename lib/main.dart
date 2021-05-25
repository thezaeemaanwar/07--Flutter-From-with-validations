import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Validation"),
      ),
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name, email, phone, password;

  bool checkboxVal = false;
  bool isPasswordCompliant(String password) {
    bool isComplient = false;
    bool hasUppercase = false;
    bool hasDigits = false;
    bool hasLowercase = false;
    bool hasSpecialCharacters = false;
    var character = '';
    var i = 0;
    if (password.isNotEmpty) {
      hasSpecialCharacters =
          password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      while (i < password.length) {
        character = password.substring(i, i + 1);
        if (isDigit(character, 0)) {
          hasDigits = true;
        } else {
          if (character == character.toUpperCase()) {
            hasUppercase = true;
          }
          if (character == character.toLowerCase()) {
            hasLowercase = true;
          }
        }
        i++;
      }
    }
    isComplient =
        hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters;
    return isComplient;
  }

  bool isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Column(children: [
        SizedBox(height: 40),
        Text(
          "Register",
          style: TextStyle(fontSize: 30),
        ),
        Text("Signup to experience new ways")
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 70),
        // width: 50.0,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40.0)),
              TextFormField(
                onSaved: (value) => {
                  this.setState(() {
                    name = value;
                  })
                },
                decoration: InputDecoration(
                    labelText: 'Name *',
                    fillColor: Colors.blue,
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.deepOrange,
                    )),
                validator: (String value) {
                  return (value == null)
                      ? 'Do not leave the name empty.'
                      : null;
                },
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (value) => {},
                decoration: InputDecoration(
                    labelText: 'Email ID *',
                    fillColor: Colors.blue,
                    icon: Icon(
                      Icons.email_outlined,
                      color: Colors.deepOrange,
                    )),
                validator: (String value) {
                  return (value == null)
                      ? 'Email ID is required'
                      : (!value.contains('@') || !value.contains('.'))
                          ? 'Invalid Email'
                          : null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (value) => {},
                decoration: InputDecoration(
                    labelText: 'Contact Number',
                    fillColor: Colors.blue,
                    icon: Icon(
                      Icons.phone_outlined,
                      color: Colors.deepOrange,
                    )),
                validator: (String value) {
                  return (value == null)
                      ? 'Contact Number is required'
                      : (value.length == 11 && int.parse(value) != null)
                          ? null
                          : 'Invalid Contact Number';
                },
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (value) => {},
                decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.blue,
                    icon: Icon(
                      Icons.lock_outline,
                      color: Colors.deepOrange,
                    )),
                validator: (String value) {
                  return (value == null)
                      ? 'You must create a password first'
                      : (value.length > 5)
                          ? (isPasswordCompliant(value))
                              ? null
                              : 'Password must contain uppercase and lowercase letters, special letters and digits'
                          : 'Psssword length must be greater than 5';
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {
                  // skey.currentState.sa
                  if (checkboxVal)
                    {
                      if (formKey.currentState.validate())
                        {this.formKey.currentState.save()}
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Please accept the terms and conditions forst')))
                    }
                },
                child: Text("Register"),
                style: ButtonStyle(
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          Checkbox(
              value: checkboxVal,
              onChanged: (bool val) => {
                    this.setState(() {
                      checkboxVal = val;
                    })
                  }),
          Text("I have read and accept Terms and Conditions")
        ],
      )
    ])));
  }
}
