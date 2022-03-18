import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lonelydubai/Model/AllTours.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Themes/AppTheme.dart';

class BookTour extends StatefulWidget {
  AllTours bookTour;

  BookTour(this.bookTour, {Key? key}) : super(key: key);

  @override
  _BookTourState createState() => _BookTourState();
}

class _BookTourState extends State<BookTour> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nOPController = TextEditingController();

  late String date;
  late DateTime selectedDate;
  bool isLoading = false;

  bookTour(String name, String phoneNumber, String tourName, String date,
      String numOfPersons, String booking_price) async {
    var totalPrice = int.parse(numOfPersons) * int.parse(booking_price);
    showLoadingDialog();
    var client = http.Client();
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('key');
    client
        .post(
      Uri.parse(
          "https://lonelydubai.com/booking/public/api/createCustomer?customer_name=$name&mobile_no=$phoneNumber&tours=$tourName&number_of_person=$numOfPersons&date=$date&status=in-processing&booking_price=$totalPrice"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showMessageDialog("assets/icons/success.svg",
            "Tour Booked!\n Our team will update you soon.", Colors.green);
      }
    });
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
            child: Container(
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

  @override
  void initState() {
    selectedDate = DateTime.now();
    date = selectedDate.toString().substring(0, 10);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppTheme.pink, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: AppTheme.charcoal, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: AppTheme.pink, // button text color
                  ),
                )),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime(2022, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        selectedDate = picked;
        date = picked.toString().substring(0, 10);
      });
    }
  }

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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 16
                          : 20),
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
                    height: MediaQuery.of(context).size.shortestSide < 550
                        ? 260.0
                        : 300.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Book your tour now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 16
                                  : 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15
                                  : 17),
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
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.shortestSide < 550
                              ? 0
                              : 3),
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 45
                          : 50,
                      child: TextField(
                        controller: _fullNameController,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 15.0
                                    : 17.0),
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: 'Jhon Doe',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 45.0
                          : 50.0,
                      child: TextField(
                        controller: _phoneNumberController,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 15.0
                                    : 17.0),
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
                            hintText: '+000000000',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Tour Date",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Card(
                      color: Colors.white,
                      elevation: 2.0,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                              color: Colors.white, width: 1.5)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide < 550
                              ? 45.0
                              : 50.0,
                          margin: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 0.0
                                      : 5.0),
                          child: SizedBox.expand(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, left: 10.0, right: 10.0),
                              child: Text(
                                date.toString(),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            550
                                        ? 15.0
                                        : 17.0,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Number of persons",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
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
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 45.0
                          : 50.0,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.shortestSide < 550
                              ? 0.0
                              : 3.0),
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
                        onSubmitted: (value) {},
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
                        height: MediaQuery.of(context).size.shortestSide < 550
                            ? 35.0
                            : 40.0,
                        width: MediaQuery.of(context).size.shortestSide < 550
                            ? 120.0
                            : 180.0,
                        margin: const EdgeInsets.only(top: 10, bottom: 30.0),
                        child: TextButton(
                          onPressed: () {
                            if (_fullNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                elevation: 8.0,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10.0),
                                content: Text("Enter your Full Name."),
                                backgroundColor: Colors.red,
                              ));
                              return;
                            }

                            if (_phoneNumberController.text.isEmpty ||
                                _phoneNumberController.text.length < 13) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                elevation: 8.0,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10.0),
                                content: Text("Enter valid Phone Number."),
                                backgroundColor: Colors.red,
                              ));
                              return;
                            }

                            if (_nOPController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                elevation: 8.0,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10.0),
                                content: Text("Enter number of persons."),
                                backgroundColor: Colors.red,
                              ));
                              return;
                            }

                            bookTour(
                                _fullNameController.text.toString(),
                                _phoneNumberController.text.toString(),
                                widget.bookTour.postTitle,
                                date,
                                _nOPController.text.toString(),
                                widget.bookTour.tourNotIncluded.isNotEmpty
                                    ? widget.bookTour.tourDiscountPrice[0]
                                    : widget.bookTour.tourPrice[0]);
                          },
                          child: Text(
                            "Book Tour",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 15.0
                                        : 17.0,
                                fontWeight:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              primary: Colors.white,
                              backgroundColor: AppTheme.pink),
                        ),
                      )
                    ],
                  )
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
