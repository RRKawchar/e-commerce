import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:ecommerce_app_flutter/constant/colors.dart';
import 'package:ecommerce_app_flutter/constant/dimensions.dart';
import 'package:ecommerce_app_flutter/ui/bottom_nav_controller.dart';
import 'package:ecommerce_app_flutter/ui/button_nav_pages/homePage.dart';
import 'package:ecommerce_app_flutter/ui/signUp_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController=TextEditingController();

  final passwordController=TextEditingController();
  bool _obscureText = true;

  signIn()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      var authCredential=userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        saveEmail(emailController.text,passwordController.text);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavController()));
      }else{
        Fluttertoast.showToast(
            msg: "Something wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
    }

  }

  saveEmail(String email,String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', email);
    sharedPreferences.setString('pass', pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox3,
            Container(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EvaIcons.arrowIosBackOutline,
                        color: whiteColor,
                      ))
                ],
              ),
            ),
            vSizedBox2,
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Let's Sign in here!",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "welcome back!",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Fill in your details",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: whiteColor),
                    ),
                  )
                ],
              ),
            ),
            vSizedBox3,
            Container(
              child: Column(
                children: [
                  vSizedBox1,
                  stylishTextField("Email", emailController),
                  vSizedBox1,
                  TextField(
                      obscureText: _obscureText,
                    controller:passwordController,
                    style: TextStyle(color: whiteColor, fontSize: 18.0),
                    decoration: InputDecoration(
                        suffixIcon: _obscureText == true
                            ? IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = false;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,color: Colors.white,
                              size: 20.w,
                            ))
                            : IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = true;
                              });
                            },
                            icon: Icon(
                              Icons.visibility_off,color: Colors.white,
                              size: 20.w,
                            )),
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold),
                        fillColor: bgColor,
                        border:const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(const Radius.circular(15.0)))),

                  )
                ],
              ),
            ),
            vSizedBox4,
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text:TextSpan(
                          children: [
                            TextSpan(
                                text: "Don't have an account??",
                                style:TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat',
                                    color: textColor
                                )
                            ),
                            TextSpan(
                                recognizer:TapGestureRecognizer()..
                                onTap=(){
                                  Navigator.pushReplacement(context, PageTransition(
                                      child: SignUpView(),
                                      type: PageTransitionType.rightToLeft
                                  ));
                                },
                                text: " Sign Up",
                                style:TextStyle(
                                    decoration: TextDecoration.underline,
                                  fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: textColor
                                )
                            )

                          ]
                      ),

                    ),
                    vSizedBox2,
                    GestureDetector(
                      child: Container(
                        width: 300.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(18.0)
                        ),
                        child:const Center(
                          child: Text("Login",
                            style: TextStyle(fontSize: 18.0,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                      onTap: (){
                        signIn();
                      },
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  stylishTextField(String text, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(color: whiteColor, fontSize: 18.0),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              emailController.clear();
            },
            icon: Icon(
              EvaIcons.backspace,
              color: textColor,
            ),
          ),
          filled: true,
          hintText: text,
          hintStyle: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold),
          fillColor: bgColor,
          border:const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(const Radius.circular(15.0)))),
    );
  }
}
