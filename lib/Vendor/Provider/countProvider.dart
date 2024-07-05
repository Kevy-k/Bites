import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CountProvider with ChangeNotifier{

final user=FirebaseAuth.instance.currentUser!;

Future<int> getOrderCount() async {
  try {
    // Replace 'orders' with the correct collection path
    QuerySnapshot orderSnapshot = await FirebaseFirestore.instance.collection('restaurants').doc(user.uid).collection('orders').get();
    return orderSnapshot.docs.length;
  } catch (e) {
    print("Error getting order count: $e");
    return 0;
  }
}


Future<double> calculateRestaurantRevenue() async {
  double totalRevenue = 0.0;

  try {
    // Fetch all orders for the specific restaurant
    QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(user.uid)
        .collection('orders')
        .get();

    // Iterate through each order document
    for (var orderDoc in orderSnapshot.docs) {
      Map<String, dynamic> orderData = orderDoc.data() as Map<String, dynamic>;
      List<dynamic> items = orderData['items'];

      // Iterate through each item in the order
      for (var item in items) {
        double itemPrice = item['Price'].toDouble();
        int itemQuantity = item['Quantity'];

        // Calculate the revenue for the item
        totalRevenue += itemPrice * itemQuantity;
      }
    }
  } catch (e) {
    print("Error calculating revenue: $e");
  }

  return totalRevenue;
}

}