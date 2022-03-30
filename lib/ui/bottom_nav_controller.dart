import 'package:ecommerce_app_flutter/constant/app_colors.dart';
import 'package:ecommerce_app_flutter/ui/button_nav_pages/cart.dart';
import 'package:ecommerce_app_flutter/ui/button_nav_pages/favourite.dart';
import 'package:ecommerce_app_flutter/ui/button_nav_pages/flutter_provider.dart';
import 'package:ecommerce_app_flutter/ui/button_nav_pages/homePage.dart';
import 'package:ecommerce_app_flutter/ui/button_nav_pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [Home(), const Favourit(), const CartPage(), const Profile(),const FlutterProvider()];

  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.dep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Cart',),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: 'profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wc_outlined),
              label: 'Provider'),

        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;

          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
