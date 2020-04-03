import '../controller/frontpage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/user.dart';
import '../my_flutter_app_icons.dart';
import '../view/socialicons.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:path/path.dart';


class FrontPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FrontPageState();
  }
}

class FrontPageState extends State<FrontPage> {
  FrontPageController controller;
  BuildContext context;
  var user = User();
  var formKey = GlobalKey<FormState>();

  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  FrontPageState() {
    controller = FrontPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    this.context = context;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      resizeToAvoidBottomPadding: true,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 30.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo2.png',
                          width: ScreenUtil.getInstance().setWidth(360),
                          height: ScreenUtil.getInstance().setHeight(150),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Text(
                        //   "MFLUENCER",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //       fontFamily: "Poppins-Bold",
                        //       fontSize: ScreenUtil.getInstance().setSp(56),
                        //       letterSpacing: .6,
                        //       fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(80),
                    ),
                    Container(
                      width: double.infinity,
                      height: ScreenUtil.getInstance().setHeight(600),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Username (Email)",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "username",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              keyboardType: TextInputType.emailAddress,
                              validator: controller.validateEmail,
                              onSaved: controller.saveEmail,
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("PassWord",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              validator: controller.validatePassword,
                              onSaved: controller.savePassword,
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                InkWell(
                                  onTap: controller.createAccount,
                                  child: Text("SignUp",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "Poppins-Bold")),
                                ),
                                Spacer(flex: 3,),
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(28)),
                                ),
                                Spacer(flex: 1,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12.0,
                            ),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text("Remember me",
                                style: TextStyle(
                                    fontSize: 12, fontFamily: "Poppins-Medium"))
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            //margin: EdgeInsets.only(left: 10, right: 10) ,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: controller.login,
                                child: Center(
                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: InkWell(
                        //     child: Container(
                        //       width: ScreenUtil.getInstance().setWidth(330),
                        //       height: ScreenUtil.getInstance().setHeight(100),
                        //       margin: EdgeInsets.only(left: 10, right: 10) ,
                        //       decoration: BoxDecoration(
                        //           gradient: LinearGradient(colors: [
                        //             Color(0xFF17ead9),
                        //             Color(0xFF6078ea)
                        //           ]),
                        //           borderRadius: BorderRadius.circular(6.0),
                        //           boxShadow: [
                        //             BoxShadow(
                        //                 color: Color(0xFF6078ea).withOpacity(.3),
                        //                 offset: Offset(0.0, 8.0),
                        //                 blurRadius: 8.0)
                        //           ]),
                        //       child: Material(
                        //         color: Colors.transparent,
                        //         child: InkWell(
                        //           onTap: () {},
                        //           child: Center(
                        //             child: Text("SIGNUP",
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontFamily: "Poppins-Bold",
                        //                     fontSize: 18,
                        //                     letterSpacing: 1.0)),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        Text("Social Login",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Poppins-Medium")),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFF102397),
                            Color(0xFF187adf),
                            Color(0xFF00eaf8),
                          ],
                          iconData: MyFlutterApp.FACEBOOKICON,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFFff4f38),
                            Color(0xFFff355d),
                          ],
                          iconData: MyFlutterApp.GOOGLEPLUSICON,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea),
                          ],
                          iconData: MyFlutterApp.TWITTERICON,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF00c6fb),
                            Color(0xFF005bea),
                          ],
                          iconData: MyFlutterApp.LINKEDINICON,
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       "New User? ",
                    //       style: TextStyle(fontFamily: "Poppins-Medium"),
                    //     ),
                    //     InkWell(
                    //       onTap: controller.createAccount,
                    //       child: Text("SignUp",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: "Poppins-Bold")),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
