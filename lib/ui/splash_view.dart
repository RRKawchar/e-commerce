import 'dart:async';
import 'package:ecommerce_app_flutter/constant/colors.dart';
import 'package:ecommerce_app_flutter/constant/dimensions.dart';
import 'package:ecommerce_app_flutter/ui/bottom_nav_controller.dart';
import 'package:ecommerce_app_flutter/ui/login_view.dart';
import 'package:ecommerce_app_flutter/ui/signUp_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SharedPreferences sharedPreferences;
  String email = '';
  String password = '';

  @override
  void initState() {
   Timer(
     Duration(seconds: 4),
       ()=>email.isEmpty?Navigator.pushReplacement(context, PageTransition(
           child: LoginView(),
           type: PageTransitionType.leftToRight
       )):BottomNavController()
   );
    super.initState();
  }
  void getEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString('email')!;
      password = sharedPreferences.getString('pass')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text('Shopex',style: TextStyle(
             fontSize: 50,
             fontWeight: FontWeight.w900,
             color: whiteColor
           ),),
            vSizedBox3,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    )
                ),
                SizedBox(width: 10,),
                Text("Loading....",style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30.0,
                  color: Colors.green,
                  fontStyle: FontStyle.italic
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
