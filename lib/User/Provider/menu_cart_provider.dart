import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuAndCartProvider with ChangeNotifier {
  bool isDragging = false;
  bool get dragging => isDragging;
  final user = FirebaseAuth.instance.currentUser!;
  Stream<Map<String, Map<String, dynamic>>> getMenuItems(String rid) {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(rid)
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
          'rid': rid,
        };
      }
      return menus;
    });
  }

  void startDragging() {
    isDragging = true;
    notifyListeners();
  }

  void stopDragging() {
    isDragging = false;
    notifyListeners();
  }

  void addtoCart(Map<String, dynamic> item) async {
    try {
      final userCart = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('myCart');
      final checkCart =
          await userCart.where('ItemName', isEqualTo: item['ItemName']).get();

      if (checkCart.docs.isNotEmpty) {
        final cartId = checkCart.docs.first;
        print(cartId);
        await userCart.doc(cartId.id).update({
          'Quantity': FieldValue.increment(1),
        });
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('myCart')
            .add({
          'ItemName': item['ItemName'],
          'Price': item['Price'],
          'Type': item['Type'],
          'ItemImage': item['ItemImage'],
          'Quantity': 1,
          'rid': item['rid'],
        });
      }
    } catch (e) {
      throw ();
    }
  }

  void increaseItemQuantity(String itemId)async{
    await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('myCart').doc(itemId).update({
      'Quantity':FieldValue.increment(1),
    });
  }
   void decreaseItemQuantity(String itemId)async{

     final userCartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('myCart')
        .doc(itemId);
    final snapshot= await userCartRef.get();
    final item=snapshot.data();
    if(item!=null){
       int currentQuantity=item['Quantity'];
       if(currentQuantity>1){
        await userCartRef.update({
          'Quantity':FieldValue.increment(-1),
        });
       }
       else{
        await userCartRef.delete();
       }
    }
   
   
  }

  void removeItem(String itemid)async{
    await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('myCart').doc(itemid).delete();
  }

num total=0;
num get totalprice=>total;
Stream<num>totalPrice()async*{

try{
  final cartSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('myCart')
        .snapshots();
    
  await for (var cartSnapshot in cartSnapshot) {
      num totalPrice = 0;
      for (var doc in cartSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final itemQuantity = data['Quantity'] ?? 0;
        final itemPrice = data['Price'] ?? 0;
        totalPrice+= itemPrice*itemQuantity;
      
    }
    total=totalPrice;
    yield totalPrice;
} 
}catch(e){}
}

Map<String,Map<String,dynamic>>cartItem={};
get cart=>cartItem;
  Stream<Map<String, Map<String, dynamic>>> getMyCart() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('myCart')
        .snapshots()
        .map((snapshot) {
      Map<String, Map<String, dynamic>> cart = {};
      for (var c in snapshot.docs) {
        var cartData = c.data();
        cart[c.id] = {
          'ItemName': cartData['ItemName'],
          'Price': cartData['Price'],
          'Type': cartData['Type'],
          'ItemImage': cartData['ItemImage'],
          'Quantity': cartData['Quantity'],
          'rid': cartData['rid'],
        };
      }
      cartItem=cart;
      return cart;
    });
  }
}
