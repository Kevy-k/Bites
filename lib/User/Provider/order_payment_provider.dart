import 'package:bites/User/Provider/userInstance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPaymentProvider with ChangeNotifier{
    final user=FirebaseAuth.instance.currentUser!;
  Future<void >placeOrder(String totalPrice)async{


    final userCart=FirebaseFirestore.instance.collection('users').doc(user.uid).collection('myCart');
    final userOrder=FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders');
    //final userPaymentHistroy=FirebaseFirestore.instance.collection('users').doc(user.uid).collection('paymentHistory').doc(orderid).collection('orderLists');
    try{
      List<Map<String,dynamic>>items=[];
      final cartSnapshot=await userCart.get();
      for(var cartdoc in cartSnapshot.docs){
        final cartdata=cartdoc.data();
        items.add(cartdata);
        await cartdoc.reference.delete();
      }
      await userOrder.add({
        'totalPrice':totalPrice,
        'items':items,
        'processed':false
      });
    }catch(e){
      throw();
    }
  }


Future<Map<String, Map<String, dynamic>>> retrieveOrders() async {
  
  try {
    final userOrders = await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders');
    final orderSnapshot = await userOrders.get();
    Map<String, Map<String, dynamic>> ordersMap ={};
    for(var doc in orderSnapshot.docs){
      ordersMap[doc.id]=doc.data();
    }
    return ordersMap;
  } catch (e) {
    throw();
  }
}

// Future<void> distributeOrdersToRestaurants() async {
//   try {
//     Map<String, Map<String, dynamic>> orders = await retrieveOrders();

//     for (var order in orders.values) {
//       List<dynamic> items = order['items']; 

//       for (var item in items) {
//         String rid = item['rid'];
//         await FirebaseFirestore.instance
//             .collection('restaurants')
//             .doc(rid)
//             .collection('orders')
//             .add(item);
//       }
//     }
//   } catch (e) {
//     print("Error distributing orders: $e");
//   }
// }

Future<Map<String, Map<String, dynamic>>> retrieveUnprocessedOrders() async {
  try {
    final userOrders = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders')
      .where('processed', isEqualTo: false);
    final orderSnapshot = await userOrders.get();
    Map<String, Map<String, dynamic>> ordersMap = {};

    for (var doc in orderSnapshot.docs) {
      ordersMap[doc.id] = doc.data();
    }
    return ordersMap;
  } catch (e) {
    throw e;
  }
}



Future<void> distributeOrdersToRestaurants(BuildContext context) async {
  final address = Provider.of<UserProfile>(context, listen: false).address;

  try {
    Map<String, Map<String, dynamic>> orders = await retrieveUnprocessedOrders();

    for (var orderId in orders.keys) {
      Map<String, dynamic> order = orders[orderId]!;
      List<dynamic> items = order['items'];

      Map<String, List<Map<String, dynamic>>> restaurantOrders = {};

      for (var item in items) {
        String rid = item['rid'];
        if (!restaurantOrders.containsKey(rid)) {
          restaurantOrders[rid] = [];
        }
        restaurantOrders[rid]!.add(item);
      }

      for (var entry in restaurantOrders.entries) {
        String rid = entry.key;
        List<Map<String, dynamic>> restaurantItems = entry.value;

        await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(rid)
            .collection('orders')
            .doc(orderId)
            .set({
          'Address': address,
          'Items': restaurantItems,
        });
      }
       await FirebaseFirestore.instance.collection('users').doc(user.uid)
        .collection('orders').doc(orderId).update({
          'processed': true,
      });
    }
  } catch (e) {
    print("Error distributing orders: $e");
  }
}

}

