import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class MenuProvider with ChangeNotifier{

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
 final user=FirebaseAuth.instance.currentUser!;

  Future<bool>addMenus(
    String item,int price,String type,PlatformFile itemImg
  )async{
    String fileUrl;
    try{
      _startUploading();
      String fileName=itemImg.name;
       Reference storageRef =
            FirebaseStorage.instance.ref().child('restaurantMenu/$fileName');
        UploadTask uploadTask = storageRef.putFile(File(itemImg.path!));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        String url = await taskSnapshot.ref.getDownloadURL();
        fileUrl=url;

        await FirebaseFirestore.instance.collection('restaurants').doc(user.uid).collection('menu').add({
            'ItemName':item,
            'Price':price,
            'Type':type,
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
}