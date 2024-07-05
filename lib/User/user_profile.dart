import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/User/my_cart.dart';
import 'package:bites/User/refunds_paymentHistory.dart';
import 'package:bites/User/deleteAccount.dart';
import 'package:bites/User/setAddress.dart';
import 'package:bites/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
   UserProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 245, 239, 239),
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 700,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        title: Consumer<UserProfile>(builder: (context, value, child) {
                          return Text(
                         value.Getuser.toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        );
                        },),
                        subtitle: Text(
                          "+91 8714748479",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const MyCart())),
                        style: ListTileStyle.drawer,
                        leading: Icon(Icons.shopping_cart),
                        title: Text(
                          "My Cart",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        subtitle: Text(
                          "Edit & checkout your cart",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                       SetAddress())),
                          style: ListTileStyle.drawer,
                          leading: Icon(Icons.location_pin),
                          title: Text(
                            "Addresses",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          subtitle: Text(
                            "Edit address",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                          splashColor: Colors.grey,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RefundAndPaymentPage()));
                          },
                          style: ListTileStyle.drawer,
                          leading: Icon(Icons.payment),
                          title: Text(
                            "Payment & Refunds",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          subtitle: Text(
                            "Refund status & Payment ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                          splashColor: Colors.grey,
                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DeleteAccount())),
                          style: ListTileStyle.drawer,
                          leading: Icon(Icons.account_box),
                          title: Text(
                            "My Account",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          subtitle: Text(
                            "Delete account",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    try {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyApp()));
                    } on FirebaseAuthException catch (e) {
                      // ignore: avoid_print
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:const Text(
                          'Logout Failed. Try again later',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
