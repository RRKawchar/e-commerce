import 'package:ecommerce_app_flutter/business_logic/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlutterProvider extends StatelessWidget {
  const FlutterProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _counter=Provider.of<Counter>(context,listen: true);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Text(
              _counter.value.toString(),
              style: const TextStyle(fontSize: 50),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                  _counter.increment();
                    },
                    child: const Text("Increment")
                ),
                ElevatedButton(
                    onPressed: (){
                     _counter.decrement();
                    },
                    child: const Text("Decrement")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
