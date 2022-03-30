import 'package:ecommerce_app_flutter/business_logic/counter.dart';
import 'package:ecommerce_app_flutter/ui/user_from.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'ui/splash_view.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>Counter())
    ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(375,812),
      builder: (){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Montserrat'
          ),
          home: SplashView(),
        );
      },
    );
  }
}

