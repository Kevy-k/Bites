import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class VendorRequestProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> _item = {};
  Map<String, Map<String, dynamic>> get items => _item;
  bool _Updating = false;
  bool get Updating => _Updating;

  void startUpdating() {
    _Updating = true;
    notifyListeners();
  }

  void updatComplete() {
    _Updating = false;
    notifyListeners();
  }

  Future<void> getItems() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('vendors')
          .where('approved', isEqualTo: false)
          .get();
      Map<String, Map<String, dynamic>> tempItems = {};
      for (var vendor in snapshot.docs) {
        final data = vendor.data();
        List<dynamic> attachments = data['attachments'] ?? [];
        tempItems[vendor.id] = {
          'ownerName': data['ownerName'],
          'licenseId': data['licenseId'],
          'email': data['email'],
          'approved': data['approved'],
          'phone': data['phone'],
          'img': attachments[0],
          'licenseProof': attachments[1],
        };
      }

      _item = tempItems;
      notifyListeners();
    } catch (e) {
      throw ();
    }
  }

  Future<void> acceptRequest(String uid) async {
    startUpdating();
    CollectionReference userCollection =
        await FirebaseFirestore.instance.collection("vendors");
    try {
      userCollection.doc(uid).update({'approved': true});
      _item.clear;
      updatComplete();
      getItems();
    } catch (e) {
      throw ();
    }
  }

  Future<void> deleteUserData(String userId) async {
    // Get a reference to the user's document
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);
    await userDoc.delete();
  }

  Future<void> deleteAccount(String uid) async {
    try {
      notifyListeners();
      await deleteUserData(uid);
      notifyListeners();
    } catch (e) {
      print("Error deleting user account: $e");
      // Handle error
    }
  }
}
