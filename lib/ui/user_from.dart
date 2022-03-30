import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:ecommerce_app_flutter/ui/bottom_nav_controller.dart';
import 'package:ecommerce_app_flutter/widgetss/customButton.dart';
import 'package:ecommerce_app_flutter/widgetss/myTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserFrom extends StatefulWidget {
  const UserFrom({Key? key}) : super(key: key);

  @override
  _UserFromTestState createState() => _UserFromTestState();
}

class _UserFromTestState extends State<UserFrom> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collecRef =
        FirebaseFirestore.instance.collection("user-data");
    return _collecRef
        .doc(currentUser!.email)
        .set({
          "name": _nameController.text,
          "phone": _phoneController.text,
          "date": _dobController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => BottomNavController())))
        .catchError((error) => Fluttertoast.showToast(
            msg: "Something is wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Submit the form to continue.",
                style: TextStyle(fontSize: 22.sp, color: AppColors.dep_orange),
              ),
              Text(
                "We will not share your information with anyone.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFFBBBBBB),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              myTextField(
                  "Enter your name", TextInputType.text, _nameController),
              myTextField("Enter your phone number", TextInputType.number,
                  _phoneController),
              TextField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: "Date of birth",
                    suffixIcon: IconButton(
                      onPressed: () {
                        _selectDateFromPicker(context);
                      },
                      icon: Icon(Icons.calendar_today_outlined),
                    )),
              ),
              TextField(
                controller: _genderController,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: "Chose your gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    )),
              ),
              myTextField(
                  "Enter your age", TextInputType.number, _ageController),
              SizedBox(
                height: 50.h,
              ),
              CustomButton("Continue", () {
                sendUserDataToDB();
              })
            ],
          ),
        ),
      ),
    ));
  }
}
