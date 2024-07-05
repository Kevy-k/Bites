import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class VendorRegisterProvider with ChangeNotifier {
  bool _showloading = false;
  bool get isuploading => _showloading;

//functions to trigger a circularProgress indicator
  void _startUploading() {
    _showloading = true;
    notifyListeners();
  }

  void _uploadComplete() {
    _showloading = false;
    notifyListeners();
  }

  Future<bool> registerVendor(
    String ownerName,
    String licenseId,
    String email,
    String phone,
    String password,
    List<PlatformFile> files,
  ) async {
    try {
      _startUploading();
      //uploading vendors attachments to firebase storage and getting the download link in a list
      List<String> firleUrls = [];
      for (var file in files) {
        String fileName = file.name;
        Reference storageRef =
            FirebaseStorage.instance.ref().child('vendorUploads/$fileName');
        UploadTask uploadTask = storageRef.putFile(File(file.path!));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        String fileUrl = await taskSnapshot.ref.getDownloadURL();
        firleUrls.add(fileUrl);
      }
      // Create a vendor account which will not be active until approved by admin
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //Saving user details
      await FirebaseFirestore.instance
          .collection('vendors')
          .doc(userCred.user?.uid)
          .set({
        'ownerName': ownerName.trim(),
        'licenseId': licenseId.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'attachments': firleUrls,
        'approved': false,
        'rights':"vendor",
      });
      FirebaseAuth.instance.signOut();
      _uploadComplete();
      return true;
    } catch (e) {
      print(e);
      FirebaseAuth.instance.signOut();
      return false;
    }
  }
}

// 32A21DEF-ABBB-4C3E-A87D-3B78226D197F
