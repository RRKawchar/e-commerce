import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomButton(String buttonText,onPressed){
  
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      child: Text(
        buttonText,style: TextStyle(
          color: Colors.white, fontSize: 18.sp),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.dep_orange,
        elevation: 3,
      ),
    )
  );
}