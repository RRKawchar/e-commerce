import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget CustomButtonTwo(String buttonTxt,onPressed){
  return GestureDetector(
    child: Center(
      child: Container(
        width: 300.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: AppColors.dep_orange,
            borderRadius: BorderRadius.circular(18.0)),
        child:  Center(
          child: Text(
            buttonTxt,
            style:TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat'),
          ),
        ),
      ),
    ),
    onTap: () {
     onPressed;
    },
  );
}