
import 'package:bites/User/Provider/userInstance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetAddress extends StatefulWidget {
   SetAddress({super.key});

  @override
  State<SetAddress> createState() => _SetAddressState();
}

class _SetAddressState extends State<SetAddress> {
final changeAddress=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.background,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<UserProfile>(builder: (context,value,child){
            value.getUsername();
            return Column(
              children: [
                const Text("Your current address : ",style: TextStyle(fontSize: 18)),
                Text(value.address,style: TextStyle(color:Theme.of(context).colorScheme.primary,fontSize: 18),),
              ],
            );
            
          }),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: 
            TextField(
                              controller:  changeAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 31, 31, 31),
                                filled: true,
                                alignLabelWithHint: true,
                                label: Text(
                                  "Address",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 191, 82, 43)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
          ),
                        
                        Consumer<UserProfile>(builder: (context,value,child){
                          if(value.loading){
                            return const CircularProgressIndicator();
                          }
                          else{
                            return    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                          foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary)
                        ),
                        onPressed: ()async{
                        await  Provider.of<UserProfile>(context,listen: false).changeAddress(context, changeAddress.text.trim());
                       
                        }, child:const Text("Change"));
                          }
                        })
                    
        ],
      ),
    );
  }
}