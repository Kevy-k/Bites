import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser!;
  get userCred=>user;
  get Getuser => user.email;
  Map<String, dynamic> userInstanceData = Map();
  Map<String,dynamic> get userdata => userInstanceData;
  String userName = "";
  get userFirstName => userName;
  String city = "";
  get City => city;
  String address = "";
  get Address => address;
  bool deleting=false;
  get isdeleting=>deleting;
  bool _isloading=false;
 bool get loading=>_isloading;


  Future<void> getUsername() async {
    final db = FirebaseFirestore.instance;
    db
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get()
        .then((snapshot) {
      for (var docsnap in snapshot.docs) {
        final data = docsnap.data();
        String username = data['first name'];
        city = data['city'];
        address=data['address'];
        userInstanceData = data;
        userName = username;
        notifyListeners();
      }
    });
  }

  Stream<bool> getApproved() {
    return FirebaseFirestore.instance
        .collection('vendors')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot['approved'];
    });
  }


Future<void> deleteUserData() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Get a reference to the user's document
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    // Get all subcollections within the user's document
    QuerySnapshot userSubcollections = await userDoc.collection('orders').get();
    for (var subDoc in userSubcollections.docs) {
      await subDoc.reference.delete();
    }

    // Delete the user's main document
    await userDoc.delete();
  }
}


Future<void> deleteUserAccount() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    await user.delete();
  }
}


Future<void> deleteAccount() async {
  try {
    deleting=true;
    notifyListeners();
    await deleteUserData();
    await deleteUserAccount();
    deleting=false;
    notifyListeners();
  } catch (e) {
    print("Error deleting user account: $e");
    // Handle error
  }
}




  void setLoading(bool x) {
    _isloading = x;
    notifyListeners();
  }


Future<void>changeAddress(context,String address)async{
  try{
    setLoading(true);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'address':address,
    });
    setLoading(false);
  }
  catch(e){
    throw();
  }
}
}
