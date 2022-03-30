import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:ecommerce_app_flutter/constant/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 TextEditingController? _nameController;
 TextEditingController? _phoneController;
 TextEditingController? _ageController;

  setDataToTextField(data){
    return Column(
      children: [
        TextFormField(
          controller: _nameController=TextEditingController(text: data['name']),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _phoneController=TextEditingController(text: data['phone']),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
         controller: _ageController=TextEditingController(text: data['age']),
        ),
        vSizedBox3,
        GestureDetector(
          child: Center(
            child: Container(
              width: 300.0,
              height: 50.0,
              decoration: BoxDecoration(
                  color: AppColors.dep_orange,
                  borderRadius: BorderRadius.circular(18.0)),
              child: const Center(
                child: Text(
                  "Update",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
          onTap: () {
            UpdateData();
          },
        )
      ],
    );
  }
  UpdateData(){
    CollectionReference _collectionRef=FirebaseFirestore.instance.collection('user-data');
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
       {
       "name":_nameController!.text,
       "phone":_phoneController!.text,
       "age":_ageController!.text,
       }
    ).then((value) => Fluttertoast.showToast(
        msg: "Update Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user-data')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              var data=snapshot.data;
              if(data==null){
                return Center(
                  child: Text("Loading",style: TextStyle(fontSize: 20,color: AppColors.dep_orange),),
                );
              }
              return setDataToTextField(data);
            },

          ),
        ),
      ),
    );
  }
}
