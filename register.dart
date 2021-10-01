import 'package:flutter/material.dart';
import 'package:socialmedia/menu.dart';
import 'package:socialmedia/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _usernameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _anotherpasswordController;

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

    final passwordField = TextFormField(
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
    );

    final usernameField = TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        hintText: "username",
        labelText: "Username",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final anotherpasswordField = TextFormField(
      controller: _anotherpasswordController,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        hintText: "password",
        labelText: "Re-enter Password",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final fields = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
          usernameField,
          anotherpasswordField,
        ],
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try {
            User user =
                (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController!.text,
              password: _passwordController!.text,
            )) as User;
            if (user != null) {
              UserInfo updateUser = UserInfo as UserInfo;
              updateUser = _usernameController!.text as UserInfo;
              user.updateProfile();
            }
          } catch (e) {
            print(e);
            _emailController!.text = "";
            _passwordController!.text = "";
            _usernameController!.text = "";
            _anotherpasswordController!.text = "";
            Navigator.of(context).pushNamed(AppRoutes.menu);
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Already a Member?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              child: Text(
                "Login",
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
