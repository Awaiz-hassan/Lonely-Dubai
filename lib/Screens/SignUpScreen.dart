import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../Themes/AppTheme.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: MediaQuery.of(context).size.shortestSide < 550
            ? const EdgeInsets.only(left: 20.0, top: 10, right: 20)
            : const EdgeInsets.only(left: 30.0, top: 20, right: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20, top: 20.0, bottom: 20),
                  child: Icon(Icons.arrow_back_ios_rounded),
                ),
              ),
              Text(
                "Lets get Started!",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.shortestSide < 550
                        ? 25
                        : 30,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Create an account to explore all features of lonely dubai",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 14
                          : 18,
                      color: Colors.grey),
                ),
              ),
              Container(
                height:
                    MediaQuery.of(context).size.shortestSide < 550 ? 200 : 300,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Image.asset("assets/images/signup.png"),
              ),
              Padding(
                padding: MediaQuery.of(context).size.shortestSide < 550
                    ? const EdgeInsets.all(0.0)
                    : const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 25
                          : 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: SvgPicture.asset(
                          "assets/icons/mail_icon.svg",
                          height: 30,
                          color: Colors.grey,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(left: 30.0),
                      height: 40,
                      width: double.infinity,
                      child: TextField(
                        controller: email,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 15.0
                                    : 17.0),
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                            hintText: 'jhondoe@mail.com',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: MediaQuery.of(context).size.shortestSide < 550
                    ? const EdgeInsets.only(top: 10.0)
                    : const EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: SvgPicture.asset(
                            "assets/icons/person.svg",
                            height: 20,
                            color: Colors.grey,
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          controller: name,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 15.0
                                      : 17.0),
                          cursorColor: AppTheme.black,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              hintText: '0Jhondoe',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: MediaQuery.of(context).size.shortestSide < 550
                    ? const EdgeInsets.only(top: 10.0)
                    : const EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: SvgPicture.asset(
                            "assets/icons/lock_icon.svg",
                            height: 20,
                            color: Colors.grey,
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          controller: password,
                          obscureText: passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 15.0
                                      : 17.0),
                          cursorColor: AppTheme.black,
                          decoration: InputDecoration(
                              suffix: IconButton(
                                  onPressed: () {
                                    if (passwordVisible) {
                                      setState(() {
                                        passwordVisible = false;
                                      });
                                    } else {
                                      setState(() {
                                        passwordVisible = true;
                                      });
                                    }
                                  },
                                  icon: passwordVisible
                                      ? const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.visibility_outlined,
                                          size: 20,
                                        )),
                              contentPadding: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: MediaQuery.of(context).size.shortestSide < 550
                    ? const EdgeInsets.only(top: 10.0)
                    : const EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: SvgPicture.asset(
                            "assets/icons/lock_icon.svg",
                            height: 20,
                            color: Colors.grey,
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          controller: confirmPassword,
                          obscureText: passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 15.0
                                      : 17.0),
                          cursorColor: AppTheme.black,
                          decoration: InputDecoration(
                              suffix: IconButton(
                                  onPressed: () {
                                    if (passwordVisible) {
                                      setState(() {
                                        passwordVisible = false;
                                      });
                                    } else {
                                      setState(() {
                                        passwordVisible = true;
                                      });
                                    }
                                  },
                                  icon: passwordVisible
                                      ? const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.visibility_outlined,
                                          size: 20,
                                        )),
                              contentPadding: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: TextButton(
                  onPressed: () {
                    if (name.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Enter your name!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email.text.trim()) ||
                        email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Enter valid email!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Enter valid password!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    if (confirmPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Enter valid password!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    if (password.text.trim().length < 5 ||
                        confirmPassword.text.trim().length < 5) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Choose a strong password!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (password.text != confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Passwords should be same!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    registerUser(name.text.trim(), email.text.trim(),
                        password.text.trim());
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      primary: Colors.white,
                      backgroundColor: AppTheme.pink),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          isLoading = true;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
                height: 200,
                child: Center(
                    child: Lottie.asset('assets/animations/loading.json',
                        height: 60.0))),
          );
        }).then((_) => isLoading = false);
  }

  showMessageDialog(String imagePath, String message, Color color) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: SvgPicture.asset(
                          imagePath,
                          height: 45,
                          color: color,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 40, left: 20, right: 20),
                          child: Text(
                            message,
                            style:
                                TextStyle(fontSize: 16, color: AppTheme.black),
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                )),
          );
        });
  }

  registerUser(String name, String email, String password) async {
    showLoadingDialog();
    var client = http.Client();
    String registerUrl =
        "https://lonelydubai.com/booking/public/api/createUser?name=$name&email=$email&password=$password&conf_password=$password";
    try {
      var response = await client.post(Uri.parse(registerUrl));
      if (response.statusCode == 201) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showMessageDialog("assets/icons/success.svg",
            "User Registered!\n Please login to continue", Colors.green);
      } else if (response.statusCode == 401) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showMessageDialog(
            "assets/icons/error.svg", "Email already exists!", Colors.red);
      }
    } on Exception {
      if (isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      showMessageDialog("assets/icons/error.svg", "Server Error", Colors.red);
    }
  }
}
