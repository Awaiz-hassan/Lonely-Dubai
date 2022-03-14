import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Themes/AppTheme.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, top:10, right: 20),
            child: SingleChildScrollView(

              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding:  EdgeInsets.only(right: 20,top: 20.0,bottom: 20),
                      child: Icon(Icons.arrow_back_ios_rounded),
                    ),
                  ),

                  const Text(
                    "Lets get Started!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Create an account to explore all features of lonely dubai",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin:const EdgeInsets.only(top: 30.0,bottom: 20.0),
                    child: Image.asset("assets/images/signup.png"),
                  ),
                  const Text(
                    "Sign Up",
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
                                hintText: 'jhondoe@mail.com',
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
                              style: TextStyle(

                                  fontSize:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 15.0
                                      : 17.0),
                              cursorColor: AppTheme.black,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                                  hintText: 'Jhondoe',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),


                  Container(
                    margin:const EdgeInsets.only(top: 10.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(margin:const EdgeInsets.only(top: 15.0),child: SvgPicture.asset(
                            "assets/icons/phone_icon.svg",
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

                              style: TextStyle(

                                  fontSize:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 15.0
                                      : 17.0),
                              cursorColor: AppTheme.black,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin:const EdgeInsets.only(top: 10.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(margin:const EdgeInsets.only(top: 15.0),child: SvgPicture.asset(
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
                        ),


                      ],
                    ),
                  ),

                  Container(
                    margin:const EdgeInsets.only(top: 10.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(margin:const EdgeInsets.only(top: 15.0),child: SvgPicture.asset(
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
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),


                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: const EdgeInsets.only(top: 50.0,bottom: 50.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
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
}
