import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class SpecialsProvider with ChangeNotifier{

bool _showloading = false;
  bool get isuploading => _showloading;
  void _startUploading() {
    _showloading = true;
    notifyListeners();
  }

  void _uploadComplete() {
    _showloading = false;
    notifyListeners();
  }

  Future<bool>addSpecials(String itemName,PlatformFile img)async{
    String fileUrl;
    try{
      _startUploading();
      String fileName=img.name;
       Reference storageRef =
            FirebaseStorage.instance.ref().child('restaurantMenu/$fileName');
        UploadTask uploadTask = storageRef.putFile(File(img.path!));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        String url = await taskSnapshot.ref.getDownloadURL();
        fileUrl=url;

        await FirebaseFirestore.instance.collection('specials').add({
            'ItemName':itemName,
            'ItemImage':fileUrl,
        });
        _uploadComplete();
        return true;
    }catch(e){
      _uploadComplete();
      print("error$e");
      return false;
    }
  }

  Stream<Map<String,Map<String,dynamic>>>getSpecials(){
    return FirebaseFirestore.instance.collection('specials').snapshots().map((snapshot){
      Map<String,Map<String,dynamic>> specials={};
      for(var doc in snapshot.docs){
       var specialItems=doc.data();
       specials[doc.id]={
        'ItemName':specialItems['ItemName'],
        'ItemImg':specialItems['ItemImage'],
       };

      }
      return specials;
    });
  }
}