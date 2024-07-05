import 'package:bites/User/Provider/userInstance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowRestautantsProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  Map<String, Map<String, dynamic>> _nearMe = {};
  Map<String, Map<String, dynamic>> get nearMe => _nearMe;

  
  bool _isloading=false;
  bool get isloading=>_isloading;

  String _query="";
  String get searchQuery=>_query;

  void setLoading(bool x) {
    _isloading = x;
    notifyListeners();
  }


Future<void>addCity(context,String city)async{
  try{
    setLoading(true);
    final provider=Provider.of<UserProfile>(context,listen: false);
    await FirebaseFirestore.instance.collection('users').doc(provider.user.uid).update({
      'city':city,
    });
    provider.getUsername();
    setLoading(false);
  }
  catch(e){
    throw();
  }
}

  Future<Map<String, Map<String, dynamic>>> restaurantsNearMe(context) async {
    final _userCity =
        Provider.of<UserProfile>(context).city;
    print(_userCity);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .where('City', isEqualTo: _userCity)
          .get();
      Map<String, Map<String, dynamic>> tempItems = {};
      for (var r in snapshot.docs) {
        final data = r.data();
        tempItems[r.id] = {
          'Name': data['Name'] ?? 'Unknown',
          'City': data['City'] ?? 'Unknown',
          'Pincode': data['Pincode'] ?? '000000',
          'District': data['District'] ?? 'Unknown',
          'Landmark': data['Landmark'] ?? 'Unknown',
          'State': data['State'] ?? 'Unknown',
          'Phone': data['Phone'] ?? '0000000000',
          'Catagory': data['Catagory'] ?? 'Unknown',
          'Type': data['Type'] ?? 'Unknown',
          'Rating': data['Rating'] ?? '0.0',
          'Img': data['Img'] ??
              'https://mytastycurry.com/wp-content/uploads/2020/04/Cafe-style-cold-coffee-with-icecream.jpg',
        };
      }

      return tempItems;
    } catch (e) {
      print('Error fetching restaurants: $e');
      // Handle the error as needed
      return {};
    }
  }


Stream < Map<String,Map<String,dynamic>>> showAllrestaurants(){
  if(_query.isEmpty){

  
  return FirebaseFirestore.instance.collection('restaurants').snapshots().map((snapshot){
    Map<String,Map<String,dynamic>> restaurants={};
    snapshot.docs.forEach((doc){
      restaurants[doc.id]=doc.data() as Map<String,dynamic>;
    });
    return restaurants;
  });
  }
  else{
    return FirebaseFirestore.instance.collection('restaurants').snapshots().map((snapshot){
          Map<String,Map<String,dynamic>> restaurants={};
          Map<String,Map<String,dynamic>> result={};
    for (var doc in snapshot.docs) {
        var restaurant = doc.data() as Map<String, dynamic>;
        restaurants[doc.id] = restaurant;
        final name = restaurant['Name'].toString().toLowerCase();
        if (name.contains(_query.toLowerCase())) {
          result[doc.id] = restaurant;
        }
      }

      return _query.isEmpty ? restaurants : result;
    });
  }
}

void setQuery(String query){
  _query=query;
  print(_query);
  notifyListeners();
}












// Future<  Map<String,Map<String,dynamic>>> showAllrestaurants()async{
//   _isloading=true;
//   notifyListeners();
//   try{
//     QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('restaurants').get();
//     Map<String,Map<String,dynamic>> restaurants={};
//     for(var doc in snapshot.docs){
//     restaurants[doc.id]=doc.data() as Map<String,dynamic>;
//     }
//     return restaurants;
//   }catch(e){
//     throw();
//   }finally{
//     _isloading=false;
//     notifyListeners();
//   }
// }
}
