import 'package:bites/Admin/Provider/addSpecial_Provider.dart';
import 'package:bites/Admin/Provider/vendorRequest_Provider.dart';
import 'package:bites/User/Provider/login_provider.dart';
import 'package:bites/User/Provider/menu_cart_provider.dart';
import 'package:bites/User/Provider/order_payment_provider.dart';
import 'package:bites/User/Provider/showRestautants_provider.dart';
import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/Vendor/Provider/menuProvider.dart';
import 'package:bites/Vendor/Provider/vendorRegister_Provider.dart';
import 'package:bites/Vendor/Provider/vendor_restaurant_provider.dart';
import 'package:bites/main_page.dart';
import 'package:bites/theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProfile()),
        ChangeNotifierProvider(create: (_) => VendorRegisterProvider()),
        ChangeNotifierProvider(create: (_) => VendorRequestProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => VendorRestaurantProvider()),
        ChangeNotifierProvider(create: (_) => ShowRestautantsProvider()),
        ChangeNotifierProvider(create: (_)=> MenuProvider()),
        ChangeNotifierProvider(create: (_)=> MenuAndCartProvider()),
        ChangeNotifierProvider(create: (_)=> SpecialsProvider()),
        ChangeNotifierProvider(create: (_)=> OrderPaymentProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightMode,
          darkTheme: darkMode,
          home:  MainPage()),
    );
  }
}
