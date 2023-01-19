import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Sign Up Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final _formKey2 = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final textController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  https://stackoverflow.com/questions/63743330/how-to-a-renderflex-overflowed-by-61-pixels-on-the-bottom-on-the-top-of-the-v
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                width: 200,
                height: 250,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:
                      NetworkImage('https://i.stack.imgur.com/vXYLh.gif'),
                      fit: BoxFit.fill,
                    )),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(children: <Widget>[
                // Form EMAIL
                Form(
                  key: _formKey1,
                  // child: Padding(
                  //padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'example@gmail.com'),
                    //inputFormatters:[FilteringTextInputFormatter.allow(RegExp('\S+@\S+\.\S+'))],
/*
              onChanged: (value) {
                var test = _formKey1.currentState!.validate();
                developer.log("$test");
                setState(() {
                  _isButtonEnabled = _formKey1.currentState!.validate() && _formKey2.currentState!.validate();
                });
              },
*/
                    validator: (value) {
                      //if (value == null || value.isEmpty) {
                      if (value == null || value.isEmpty) {
                        return "Fill it with your Email";
                      }
                      // using regular expression
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        //developer.log('$value');
                        setState(() {
                          _isButtonEnabled = true;
                        });
                        //_isButtonEnabled = false;
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      //  onSaved callback will has a value when button pressed which has
                      //  "_formKey1.currentState!.save();", so
                      // TODO: create storage to store data of form
                      developer.log('Email field value: $value');
                    },
                  ),
                  //),
                ),
                // Form PASSWORD
                Form(
                  key: _formKey2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: textController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                      /*
              onChanged: (value) {
                var test = _formKey2.currentState!.validate();
                developer.log("$test");
                setState(() {
                  _isButtonEnabled = _formKey1.currentState!.validate() &&
                      _formKey2.currentState!.validate();
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Form 2 is empty";
                }
                return null;
              },
*/
                      /*
              onSaved: (value){
                //  onSaved callback will has a value when button pressed which has
                //  "_formKey1.currentState!.save();", so
                // TODO: create storage to store data of form
                developer.log('Email field value: $value');
              },
              */
                    ),
                  ),
                ),
                FlutterPwValidator(
                    controller: textController,
                    minLength: 6,
                    uppercaseCharCount: 2,
                    numericCharCount: 3,
                    specialCharCount: 1,
                    width: 400,
                    height: 150,
                    onSuccess: () {
                      //  onSaved callback will has a value when button pressed which has
                      //  "_formKey1.currentState!.save();", so
                      // TODO: create storage to store data of form
                      //  developer.log('Password here field value: $value');

                      if (_formKey1.currentState?.validate() == true &&
                          _formKey2.currentState!.validate() == true) {
                        setState(() {
                          _isButtonEnabled = true;
                        });
                      }
                    },
                    onFail: () {
                      if (_formKey1.currentState?.validate() == true &&
                          _formKey2.currentState!.validate() == true) {
                        setState(() {
                          _isButtonEnabled = false;
                        });
                      }
                    }),
                Padding(
                    padding: const EdgeInsets.all(30),
                    child: SizedBox(
                      height: 50, //height of button
                      width: 500, //width of button
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          //primary: Colors.purpleAccent,
                          backgroundColor: Colors.teal, // Background Color
                        ),
                        // Both form Validator valid return bool ? true, enable button and closure function return process data : false, return null
                        onPressed: _isButtonEnabled
                            ? () {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Data')),
                          );
                          // onSaved
                          if (_formKey1.currentState!.validate()) {
                            _formKey1.currentState!.save();
                          }
                        }
                            : null,
                        child: const Text("SIGNUP"),
                      ),
                      //parameters of Button class
                    ))
              ])),
        ],
      ),
    );
  }
}
/*
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SIGNUP Flutter Dev"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Center(
                child: Container(
                  width: 500,
                  height: 250,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
            ),
            Form(
              key: _formKey1,
              child: Column(children: [
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  // FORM 1 EMAIL
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'example@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  // FORM 2 PASSWORD
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                // TODO : add margin
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );

     */
