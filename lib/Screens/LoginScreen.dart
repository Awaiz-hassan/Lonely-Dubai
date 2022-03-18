import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lonelydubai/Model/LoginUser.dart';
import 'package:lonelydubai/Screens/MainTabScreen.dart';
import 'package:lonelydubai/Screens/SignUpScreen.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Themes/AppTheme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: MediaQuery.of(context).size.shortestSide < 550
            ? const EdgeInsets.only(left: 20.0, top: 40, right: 20)
            : const EdgeInsets.only(left: 30.0, top: 60, right: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.shortestSide < 550
                        ? 25
                        : 30,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Login to your existing account to enjoy our app",
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
                child: Image.asset("assets/images/login.png"),
              ),
              Padding(
                padding: MediaQuery.of(context).size.shortestSide < 550
                    ? const EdgeInsets.all(0.0)
                    : const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Sign In",
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
                            hintText: 'jhondoe@gmail.com',
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
                          obscureText: isObscure,
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
                                    if (isObscure) {
                                      setState(() {
                                        isObscure = false;
                                      });
                                    } else {
                                      setState(() {
                                        isObscure = true;
                                      });
                                    }
                                  },
                                  icon: isObscure
                                      ? const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.visibility_outlined,
                                          size: 20,
                                        )),
                              contentPadding: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 3.0),
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 20.0),
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 14
                                    : 16),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  onPressed: () {
                    if (email.text.trim().isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email.text.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Enter valid email!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (password.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 8.0,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10.0),
                        content: Text("Enter valid email!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    loginUser(email.text.trim(), password.text.trim());
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.shortestSide < 550
                            ? 15
                            : 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      primary: Colors.white,
                      backgroundColor: AppTheme.pink),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ? ",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15
                                  : 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          "Create new one",
                          style: TextStyle(
                              color: AppTheme.pink,
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 15
                                      : 18),
                        ),
                      ),
                    )
                  ],
                ),
              )
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
        barrierDismissible: true,
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

  loginUser(String email, String password) async {
    showLoadingDialog();
    String loginUrl =
        "https://lonelydubai.com/booking/public/api/login?email=$email&password=$password";
    var client = http.Client();

    try {
      var response = await client.post(Uri.parse(loginUrl));
      if (response.statusCode == 200) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        var jsonString = response.body;
        LoginUser loginUser;
        loginUser = loginUserFromJson(jsonString);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('key', loginUser.success);
        await prefs.setBool('user_logged', true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabScreen()));
      } else if (response.statusCode == 401) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
          showMessageDialog("assets/icons/error.svg",
              "Incorrect username/password", Colors.red);
        }
      } else {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
          showMessageDialog("assets/icons/error.svg",
              "Unable to login.\nPlease try again later!", Colors.red);
        }
      }
    } on Exception {
      if (isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      showMessageDialog("assets/icons/error.svg", "Server error", Colors.red);
    }
  }
}
