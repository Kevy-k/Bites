import 'package:bites/Admin/addSpecials.dart';
import 'package:bites/Admin/vendor_request.dart';
import 'package:bites/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Column(
            children: [
              const SizedBox(height: 150,),
              Text("ADMIN PANEL",style: TextStyle(color:Theme.of(context).colorScheme.background,fontSize: 25),),
              
                Divider(
                indent: 50,
                thickness: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              
            
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                   leading: Icon(Icons.support_agent_sharp,color: Theme.of(context).colorScheme.background,),
                  title:  Text("Vendor Request",style: TextStyle(color: Theme.of(context).colorScheme.background),),
                  onTap: () {
                      Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const VendorRequests()));
                  },
                ),
              ),
              Divider(
                indent: 50,
                thickness: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              
      
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                   leading: Icon(Icons.add,color: Theme.of(context).colorScheme.background,),
                  title:  Text("Add Specials",style: TextStyle(color: Theme.of(context).colorScheme.background),),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const AddSpecials()));
                  },
                ),
              ),
               Divider(
                indent: 50,
                thickness: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                   leading: Icon(Icons.logout_rounded,color: Theme.of(context).colorScheme.background,),
                  title:  Text("Logout",style: TextStyle(color: Theme.of(context).colorScheme.background),),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MainPage()));
                  },
                ),
              )
            ],
          ));

  }
}