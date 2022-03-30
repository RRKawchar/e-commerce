import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:ecommerce_app_flutter/constant/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("user-cart");
    return collectionRef.doc(currentUser!.email).collection("items").doc().set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "iamge": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(
        msg: "Cart added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0));
  }

  Future addToFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("user-favorite");
    return collectionRef
        .doc(currentUser!.email)
        .collection("favorite")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "iamge": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(
            msg: "Favorite added",
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: CircleAvatar(
            backgroundColor: AppColors.dep_orange,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user-favorite')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("favorite")
                .where('name', isEqualTo: widget._product['product-name'])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text("Favorite is empty"),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.dep_orange,
                  child: IconButton(
                    onPressed: () {
                     snapshot.data.docs.length==0? addToFavorite():Fluttertoast.showToast(
                         msg: "Already Added favorite,Thank you",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.CENTER,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.red,
                         textColor: Colors.white,
                         fontSize: 16.0);
                    },
                    icon: snapshot.data.docs.length == 0
                        ? Icon(Icons.favorite_outline, color: Colors.white)
                        : Icon(Icons.favorite, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: Image.network(widget._product['product-img']),
                  ),
                ),
                Text(
                  widget._product['product-name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget._product['product-description'],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget._product['product-price'],
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                vSizedBox3,
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user-cart')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("items")
                      .where('name', isEqualTo: widget._product['product-name'])
                      .snapshots(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    return GestureDetector(
                      child: Center(
                        child: Container(
                          width: 300.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: AppColors.dep_orange,
                              borderRadius: BorderRadius.circular(18.0)),
                          child: const Center(
                            child: Text(
                              "Add to cart",
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
                      snapshot.data.docs.length==0?addToCart():Fluttertoast.showToast(
                          msg: "Already Added Cart,Thank you",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      },
                    );
                  },

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
