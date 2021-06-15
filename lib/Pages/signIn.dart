import 'package:flutter/material.dart';
import 'package:shop_app/Models/http_exception.dart';
import 'package:shop_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

enum LoginType { SignIn, SignUp, GoogleSignIn }

class SignIn extends StatefulWidget {
  static const routename = "/auth";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                c1,
                c2,
                c4,
              ], radius: 1, tileMode: TileMode.mirror),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  height: size.height * 0.3,
                  child: SvgPicture.asset(
                    "assets/images/Sign.svg",
                    colorBlendMode: BlendMode.lighten,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Text(
                    "Login",
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Color.fromRGBO(22, 67, 118, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: AuthCard()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  LoginType _type = LoginType.SignIn;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _obsecureText = true;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Error Occured"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("OK"))
              ],
            ));
  }

  void _obsecureTextfn() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_type == LoginType.SignIn) {
        //Log User In
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email'], _authData['password']);
      } else if (_type == LoginType.SignUp) {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email Address is already in use";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "Invalid Email";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This Password is too weak";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Email not found";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid Password";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = "Could not connect right now";
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_type == LoginType.SignIn) {
      setState(() {
        _type = LoginType.SignUp;
      });
    } else {
      setState(() {
        _type = LoginType.SignIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                onSaved: (value) {
                  _authData['email'] = value;
                },
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 16),
                    hintText: "yourname@example.com",
                    labelText: "E-Mail",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                enableSuggestions: true,
                obscureText: _obsecureText,
                onSaved: (value) {
                  _authData['password'] = value;
                },
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    hintText: "yourPassword",
                    suffixIcon: IconButton(
                        onPressed: () {
                          _obsecureTextfn();
                        },
                        icon: _obsecureText
                            ? Icon(LineIcons.lowVision)
                            : Icon(LineIcons.eye)),
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 20),
              if (_type == LoginType.SignUp)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    enabled: _type == LoginType.SignUp,
                    keyboardType: TextInputType.text,
                    validator: _type == LoginType.SignUp
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                    enableSuggestions: true,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        hintText: "confirmPassword",
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(color: Colors.blueGrey)),
                  ),
                ),
              _isLoading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width - 100,
                        child: ElevatedButton(
                            onPressed: () {
                              return _submit();
                            },
                            style: ButtonStyle(
                                animationDuration: Duration(seconds: 1),
                                backgroundColor:
                                    MaterialStateProperty.all(c3.withRed(69)),
                                elevation: MaterialStateProperty.all(3),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(16)),
                                enableFeedback: true),
                            child: Text(_type == LoginType.SignIn
                                ? "SignIn"
                                : "SignUp")),
                      ),
                    ),
              if (_type == LoginType.SignIn)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width - 100,
                    child: MaterialButton(
                        onPressed: () {},
                        elevation: 3,
                        animationDuration: Duration(seconds: 1),
                        enableFeedback: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(width: 2, color: c3)),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SignIn with Google",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              LineIcons.googlePlusG,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _type == LoginType.SignUp
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                return _switchAuthMode();
                              },
                              child: Text("SignIn instead ",
                                  style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        : Text("Don't have an account yet? ",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                    SizedBox(
                      height: 10,
                    ),
                    if (_type == LoginType.SignIn)
                      InkWell(
                        onTap: () {
                          return _switchAuthMode();
                        },
                        child: Text(
                            _type == LoginType.SignIn ? "SignUp" : "SignIn",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
