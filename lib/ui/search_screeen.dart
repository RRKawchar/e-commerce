import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_flutter/ui/product_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search by product name"
                ),
                onChanged: (val) {
                  setState(() {
                    _inputText = val;
                  });
                },

              ),
              Expanded(
                  child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('product-name', isLessThanOrEqualTo: _inputText)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something is wrong"),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                child: CircularProgressIndicator(
                                  value: 0.8,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.purple),
                                )),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Center(
                              child: Text(
                            "Loading.....",
                            style:
                                TextStyle(fontSize: 30, color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic
                                ),
                          ))
                        ],
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(data['product-name']),
                            leading: Image.network(data['imag']),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
