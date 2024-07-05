import 'package:bites/Admin/vendor_request.dart';
import 'package:bites/User/home.dart';
import 'package:bites/Vendor/confirmation.dart';
import 'package:bites/shimmer.dart';
import 'package:bites/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = FirebaseAuth.instance.currentUser!;
            if (users.email.toString() == "bitesadmin2024@gmail.com") {
              return const VendorRequests();
            } else {
              return FutureBuilder<String>(
                future: checkRights(users),
                builder: (context, rightsSnapshot) {
                  if (rightsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: ShimmerLoading());
                  } else if (rightsSnapshot.hasData) {
                    final rights = rightsSnapshot.data!;
                    if (rights == "user") {
                      
                      return const HomePage();
                    } else {
                        
                      return const VendorConfirmationPage();
                    }
                  }  
                  else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              size: 25,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              "Oops! Looks like we're having some trouble",
                              style: TextStyle(
                                  color: Colors.red[700], fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.tertiary,
                                )),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage()));
                                },
                                child: const Icon(Icons.restart_alt_sharp))
                          ],
                        )
                      ],
                    ).animate().fade().slideX(duration: Duration(seconds: 1));
                  }
                },
              );
            }
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }

  Future<String> checkRights(User u) async {
    try {
     
      DocumentSnapshot snapshotUser =
          await FirebaseFirestore.instance.collection('users').doc(u.uid).get();
      DocumentSnapshot snapshotVendor = await FirebaseFirestore.instance
          .collection('vendors')
          .doc(u.uid)
          .get();
      if (snapshotUser.exists) {
        Map<String, dynamic> snap = snapshotUser.data() as Map<String, dynamic>;
        String rights = snap['rights'];
        print(rights);
        return rights;
      } else if (snapshotVendor.exists) {
        Map<String, dynamic> snap =
            snapshotVendor.data() as Map<String, dynamic>;
        String rights = snap['rights'];
        return rights;
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      throw ();
    }
  }

  void _restartApp(BuildContext context) {}
}
