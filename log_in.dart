import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/menu.dart';
import 'package:socialmedia/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "assets/socialmedia.jpeg",
      height: mq.size.height / 4,
    );

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        hintText: "blank@example.com",
        labelText: "Email",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          controller: _passwordController,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: "password",
            labelText: "Password",
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(2.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {}),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          try {
            User user = FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController!.text,
              password: _passwordController!.text,
            ) as User;
            if (user != null) {
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          } catch (e) {
            print(e);
            _emailController!.text = "";
            _passwordController!.text = "";
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Not a Member?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                logo,
                fields,
                Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
