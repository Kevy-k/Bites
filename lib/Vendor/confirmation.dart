import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/Vendor/vendorHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorConfirmationPage extends StatefulWidget {
  const VendorConfirmationPage({super.key});

  @override
  State<VendorConfirmationPage> createState() => _VendorConfirmationPageState();
}

class _VendorConfirmationPageState extends State<VendorConfirmationPage> {

@override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProfile>(builder: (context, value, child) {
        return StreamBuilder(stream:value.getApproved(),
         builder:(context,snapshot){  
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return const VendorMainPage();
          }
          else{
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Icon(Icons.error),
                  Text("Your account is not yet approved. Come again later",style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontSize: 18),),
                 const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
                      foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.background)
                    ),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      //  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => const MyApp()));
                  }, child:const Text("Logout"))
                ],
              )
            );
          }
        });
      },
      
      ),




















      // body: Consumer<UserProfile>(builder: (context, value, child) {
      //     if(value.app){
      //       return const VendorMainPage();
      //     }else{
      //       return const Column(
      //         children: [
      //           Row(
      //             children: [
      //               Icon(Icons.error)
      //             ],
      //           ),
      //           Row(children: [
      //             Text("Your account is not yet approved. Come again later")
      //           ],)
      //         ],
      //       );
      //     }
      // },),
      
    );
  }
}