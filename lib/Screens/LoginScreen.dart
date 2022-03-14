import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lonelydubai/Screens/SignUpScreen.dart';

import '../Themes/AppTheme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 40, right: 20),
        child: SingleChildScrollView(

          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "Login to your existing account to enjoy our app",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
               Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(top: 30.0,bottom: 20.0),
                child: Image.asset("assets/images/login.png"),
              ),
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(margin:const EdgeInsets.only(top: 10.0),child: SvgPicture.asset(
                      "assets/icons/mail_icon.svg",
                      height: 30,
                      color: Colors.grey,
                    )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      height: 40,
                      width: double.infinity,
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 15.0
                                    : 17.0),
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                            hintText: 'Jhon Doe',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin:const EdgeInsets.only(top: 10.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(margin:EdgeInsets.only(top: 15.0),child: SvgPicture.asset(
                        "assets/icons/lock_icon.svg",
                        height: 20,
                        color: Colors.grey,
                      )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(left: 30.0),
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(

                              fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
                          cursorColor: AppTheme.black,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10.0,left: 20.0),
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(color: Colors.grey),
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
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
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
              
              Container(margin: const EdgeInsets.only(top: 50.0,bottom: 50.0),child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Don't have an account ?  "),
                GestureDetector(
                  onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const SignUpScreen()));

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0),
                    child: Text("Create new one",style: TextStyle(color: AppTheme.pink,fontSize: 15),),
                  ),
                )


              ],),)
            ],
          ),
        ),
      ),
    ));
  }
}
