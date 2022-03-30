
import 'package:ecommerce_app_flutter/widgetss/fetchProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favourit extends StatefulWidget {
  const Favourit({Key? key}) : super(key: key);

  @override
  _FavouritState createState() => _FavouritState();
}

class _FavouritState extends State<Favourit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: fetchProductData("user-favorite", "favorite"),
      ),
    );
  }
}
