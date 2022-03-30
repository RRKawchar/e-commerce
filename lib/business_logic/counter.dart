
import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier{
int value=0;

increment(){
  value++;
  notifyListeners();
}
decrement(){

  value--;
  notifyListeners();
}
}