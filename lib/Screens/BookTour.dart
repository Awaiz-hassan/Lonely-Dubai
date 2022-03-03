import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lonelydubai/Model/AllTours.dart';

import '../Themes/AppTheme.dart';

class BookTour extends StatefulWidget {
  AllTours bookTour;

  BookTour(this.bookTour, {Key? key}) : super(key: key);

  @override
  _BookTourState createState() => _BookTourState();
}

class _BookTourState extends State<BookTour> {


  // var email = "tony@starkindustries.com";
  // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  final _fullNameController=TextEditingController();
  final _emailAddressController=TextEditingController();
  final _phoneNumberController=TextEditingController();
  final _nOPController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppTheme.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Flexible(
                    child: Text(
                  widget.bookTour.postTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
                const SizedBox(
                  height: 50,
                  width: 50,
                )
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/form_image.png",
                    width: double.infinity,
                    height: 260,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Book your tour now",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),


                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Full Name",
                      style:
                      TextStyle(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),


                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _fullNameController,
                        style: const TextStyle(fontSize: 15.0),

                        cursorColor: AppTheme.black,
                        inputFormatters: [


                        ],
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: 'Jhon Doe',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),






                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Email Address",

                      style:
                      TextStyle(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),


                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _emailAddressController,
                        style: const TextStyle(fontSize: 15.0),
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: 'abc@mail.com',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),






                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Phone Number",
                      style:
                      TextStyle(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),


                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _phoneNumberController,
                        style: const TextStyle(fontSize: 15.0),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(13),
                            FilteringTextInputFormatter.digitsOnly,
                            NumberTextInputFormatter()

                          ],

                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: '+00 0 000 000',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),






                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Tour Date",
                      style:
                      TextStyle(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),


                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      height: 45,
                      child: TextField(
                        style: const TextStyle(fontSize: 15.0),

                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: '00-00-0000',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),





                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Number of persons",
                      style:
                      TextStyle(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),


                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _nOPController,
                        style: const TextStyle(fontSize: 15.0),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                          LimitRangeTextInputFormatter(1, 50),

                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        onSubmitted: (value) {

                        },
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(

                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: 'X Persons',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 10,bottom: 30.0),
                      child: TextButton(
                        onPressed: (){},
                        child: const Text("Book Tour"),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0),
                            primary: Colors.white,
                            backgroundColor: AppTheme.pink),
                      ),
                    )
                  ],)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }

    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}
