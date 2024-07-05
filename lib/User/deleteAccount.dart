import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Center(
          child: Consumer<UserProfile>(builder: (context,value,child){
            if(value.deleting){
              return const CircularProgressIndicator();
            }
            else{
               return  ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary)),
              onPressed: ()async {
                bool confirm=await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Account"),
                      content: const Text("Are you sure. This action cannot be undone"),
                      actions: [
                        TextButton(onPressed: (){Navigator.of(context).pop(false);}, child:const Text("Cancel")),
                        TextButton(onPressed: (){Navigator.of(context).pop(true);}, child:const Text("Delete"))
                      ],
                    );
                  },
                );
                if(confirm){
                  await Provider.of<UserProfile>(context,listen: false).deleteAccount();
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MainPage()));
                }

              },
              child: const Text("Delete Account",style: TextStyle(fontSize: 18),));
            }
           
          }),
         
        ));
  }
}
