import '../consts/colors.dart';
import '../provider/media_query.dart';
import '../screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FocusNode? pin1Focus;
  FocusNode? pin2Focus;
  FocusNode? pin3Focus;
  FocusNode? pin4Focus;
  @override
  void initState() {
    pin1Focus = FocusNode();
    pin2Focus = FocusNode();
    pin3Focus = FocusNode();
    pin4Focus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    pin1Focus!.dispose();
    pin2Focus!.dispose();
    pin3Focus!.dispose();
    pin4Focus!.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool btnEnabled = false;
  bool ispressed = false;
  bool isLoading = false;
  var pin1Controller = TextEditingController();
  var pin2Controller = TextEditingController();
  var pin3Controller = TextEditingController();
  var pin4Controller = TextEditingController();
  String _otp = '';

  errorHandling(val) {
    if (_otpCheck()) {
      Navigator.of(context).popAndPushNamed(DashboardScreen.pathName);
    }
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          content: Text("WRONG OTP"),
        ),
      );
    _otp = '';
    return null;
  }

  void _addOtp(val) {
    _otp = _otp + val;
  }

  bool _otpCheck() {
    print(_otp);
    if (_otp == '2222') {
      return true;
    }
    return false;
  }

  void _onSave() {
    _formKey.currentState!.save();
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final mq = Provider.of<MyMediaQuery>(context);
    bool noMatch = false;
    int count = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: mq.getWidth(context) * 0.04,
            right: mq.getWidth(context) * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mq.getHeight(context) * 0.03,
              ),
              Text(
                "Enter OTP",
                style: Theme.of(context).textTheme.headline3,
              ),
              Center(
                child: SizedBox(
                  height: mq.getHeight(context) * 0.15,
                ),
              ),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: mq.getWidth(context) * 0.15,
                      decoration: otpInputDecoration,
                      child: TextFormField(
                        validator: (val) {
                          errorHandling(val);
                          return null;
                        },
                        controller: pin1Controller,
                        onChanged: (val) {
                          if (val.length == 1) {
                            count++;
                            FocusScope.of(context).requestFocus(pin2Focus);
                          }
                        },
                        onSaved: (val) {
                          _addOtp(val);
                        },
                        showCursor: !isLoading,
                        autofocus: true,
                        readOnly: isLoading,
                        cursorColor: primaryColor,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: otpFieldTextStyle,
                        decoration: otpFieldDecoration,
                      ),
                    ),
                    Container(
                      width: mq.getWidth(context) * 0.15,
                      decoration: otpInputDecoration,
                      child: TextFormField(
                        controller: pin2Controller,
                        validator: (val) {
                          errorHandling(val);
                          return null;
                        },
                        onChanged: (val) {
                          if (val.length == 1) {
                            count++;
                            FocusScope.of(context).requestFocus(pin3Focus);
                          }
                          if (val.isEmpty) {
                            count--;
                          }
                        },
                        onSaved: (val) {
                          _addOtp(val);
                        },
                        showCursor: !isLoading,
                        focusNode: pin2Focus,
                        readOnly: isLoading,
                        cursorColor: primaryColor,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: otpFieldTextStyle,
                        decoration: otpFieldDecoration,
                      ),
                    ),
                    Container(
                      width: mq.getWidth(context) * 0.15,
                      decoration: otpInputDecoration,
                      child: TextFormField(
                        controller: pin3Controller,
                        validator: (val) {
                          errorHandling(val);
                          return null;
                        },
                        onChanged: (val) {
                          if (val.length == 1) {
                            count++;
                            FocusScope.of(context).requestFocus(pin4Focus);
                          }
                          if (val.isEmpty) {
                            count--;
                          }
                          print(count);
                        },
                        onSaved: (val) {
                          _addOtp(val);
                        },
                        showCursor: !isLoading,
                        focusNode: pin3Focus,
                        readOnly: isLoading,
                        cursorColor: primaryColor,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: otpFieldTextStyle,
                        decoration: otpFieldDecoration,
                      ),
                    ),
                    Container(
                      width: mq.getWidth(context) * 0.15,
                      decoration: otpInputDecoration,
                      child: TextFormField(
                        controller: pin4Controller,
                        validator: (val) {
                          errorHandling(val);
                          return null;
                        },
                        onChanged: (val) {
                          if (val.length == 1) {
                            count++;
                            FocusScope.of(context).unfocus();
                          }
                          count--;
                          print(count);
                        },
                        onSaved: (val) {
                          _addOtp(val);
                        },
                        showCursor: !isLoading,
                        focusNode: pin4Focus,
                        readOnly: isLoading,
                        cursorColor: primaryColor,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: otpFieldTextStyle,
                        decoration: otpFieldDecoration,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mq.getHeight(context) * 0.1,
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Resend OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
