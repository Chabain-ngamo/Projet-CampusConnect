import 'package:campus_connect/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class UsersProvider with ChangeNotifier {
  
  static List<UserModel> _userList = [];
  List<UserModel> get getUsers {
    return _userList;
  }


  Future<void> fetchUsers() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _userList = [];
      productSnapshot.docs.forEach((element) {
        _userList.insert(
            0,
            UserModel(
              userId: element.get('id'),
              userPhoto: element.get('photo'),
              userName: element.get('name'),
              userPromo: element.get('promo'),
            ));
      });
    });
    notifyListeners();
  }


  List<UserModel> searchQuery(String searchText) {
    List<UserModel> _searchList = _userList
        .where(
          (element) => element.userName.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }
 
}

