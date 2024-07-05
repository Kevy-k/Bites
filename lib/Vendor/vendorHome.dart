import 'package:bites/Vendor/addMenu.dart';
import 'package:bites/Vendor/orders.dart';
import 'package:bites/Vendor/showMenu.dart';
import 'package:bites/Vendor/vendor_home.dart';
import 'package:bites/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorMainPage extends StatefulWidget {
const VendorMainPage({super.key});
  

  @override
  State<VendorMainPage> createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
   final pages = [const VendorHomePage(),const ShowMenu(),const RestaurantOrders(),const AddMenu()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
      // backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        actionsIconTheme: const IconThemeData(size: 20),

        actions: [
           IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                const MainPage();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15, top: 8),
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset.zero)
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              currentIndex: _currentIndex,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.black,
                  icon: Icon(Icons.home_rounded),
                  label: "Home",
                ),
               BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book),
                  label: "Menus",
                ),
               BottomNavigationBarItem(
                  icon: Icon(Icons.pending_actions),
                  label: "Orders",
                ),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Add Menu",
                ),
               
              ],
              showSelectedLabels: true,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.white,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              selectedIconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
              unselectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.secondary,
              ),
             
              enableFeedback: true,
            ),
          ),
        ),
      ),
    );
    
  }
}