import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget fetchProductData(String collection,txt){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collection)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(txt)
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount:
          snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return Card(
              elevation: 5,
              child: ListTile(
                leading: Text(_documentSnapshot['name']),
                title: Text(
                  "\$ ${_documentSnapshot['price']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                trailing: GestureDetector(
                  child: const CircleAvatar(
                    child: Icon(Icons.remove_circle),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context){
                          return  CupertinoAlertDialog(
                            title: const Padding(
                              padding: EdgeInsets.only(right: 100),
                              child: Text(
                                "Warning!!",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            content: const Text(
                              "Are you want to delete favorite??",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15,),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('Yes'),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection(collection)
                                      .doc(FirebaseAuth.instance.currentUser!.email)
                                      .collection(txt)
                                      .doc(_documentSnapshot.id)
                                      .delete();
                                  Fluttertoast.showToast(
                                      msg: "Favorite deleted",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }
                    );


                  },
                ),
              ),
            );
          });
    },
  );
}