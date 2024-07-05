import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorRestaurantProvider with ChangeNotifier {
  bool _addedRestaurant = false;
  bool get addedRestaurant => _addedRestaurant;
  bool _waiting = false;
  bool get waiting => _waiting;
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic> userData = Map();
  Map<String, dynamic> restaurant = Map();
  Map<String, dynamic> _item = {};
  void startWaiting() {
    _waiting = true;
    notifyListeners();
  }

  void stopWaiting() {
    _waiting = false;
    notifyListeners();
  }

  void setRestaurant(bool x) {
    _addedRestaurant = x;
    notifyListeners();
  }

  Future<void> checkRestaurantAvailability() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setRestaurant(true);
        restaurant = doc.data()!;
      } else {
        setRestaurant(false);
      }
    } catch (e) {
      throw ();
    }
  }

  Future<bool> addRestaurant({
    context,
    required String name,
    required String city,
    required String pincode,
    required String district,
    required String landmark,
    required String state,
    required String phone,
    required String catagory,
    required String type,
    required String rating,
  }) async {
    startWaiting();
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('vendors')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data()!;
        List<dynamic> attachments = data['attachments'] ?? [];
        _item = {
          'ownerName': data['ownerName'],
          'licenseId': data['licenseId'],
          'email': data['email'],
          'approved': data['approved'],
          'phone': data['phone'],
          'img': attachments.isNotEmpty ? attachments[0] : null,
          'licenseProof': attachments.length > 1 ? attachments[1] : null,
        };
      }
      

      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(user.uid)
          .set({
        'Name': name,
        'City': city,
        'Pincode': pincode,
        'District': district,
        'Landmark': landmark,
        'State': state,
        'Phone': phone,
        'Catagory': catagory,
        'Type': type,
        'Rating': rating,
        'Img':_item['img'],
      });

      setRestaurant(true);
      stopWaiting();
      return true;
    } catch (e) {
      stopWaiting();
      return false;
    }
  }


  Future<Map<String, Map<String, dynamic>>> retrieveOrders() async {
  
  try {
    final userOrders = await FirebaseFirestore.instance.collection('restaurants').doc(user.uid).collection('orders');
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


Stream<Map<String, Map<String, dynamic>>> showMenu() {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(user.uid)
        .collection('menu')
        .snapshots()
        .map((snapshot) {
      Map<String, Map<String, dynamic>> menus = {};
      for (var m in snapshot.docs) {
        var data = m.data();
        menus[m.id] = {
          'ItemName': data['ItemName'],
          'Price': data['Price'],
          'Type': data['Type'],
          'ItemImage': data['ItemImage'],
        };
      }
      return menus;
    });
  }
}
